-*- text -*-

($Revision: 5.2 $)

ESS: Using The S family of statistical languages
================================================

ESS (originally S-mode) was initially designed for use with S and
S-PLUS(tm); hence, this family of statistical languages currently has
the most support.  We denote by _S_, any of the currently available
members of the family, including S 3.x, S 4.x, S-PLUS 3.x, S-PLUS 4.x,
S-PLUS 5.x, and R.  In addition, we denote by _Emacs_, one of the GNU
family of editors, either Emacs (as developed and maintained by the
Free Software Foundation) or XEmacs (which is a derivative work).

The following is covered in this document:
- general Emacs features.
- Editing files.
- running an S process as an inferior process to Emacs
- using transcripts.
- Scenarios for use (possibilities, based on actual usage)
- Philosophies

New in 5.1.2 and later: use under Microsoft Windows OS's with NTEmacs.
See the file README.SPLUS4WIN for more details.

Emacs: General features
=======================

We assume that you are familiar with Emacs terminology and syntax:
file, buffer, region, description of keys etc.  If not, please read
the New Users guide (found in the info pages, "C-h i" (by pressing
control h, i) or Tutorial, "C-h t").

To find the key-sequences for commands, view the keymap (C-h b) or
view help for the current mode (C-h m).

ESS[S]: Editing Files
=====================

ESS[S] is the mode for editing S language files.  This mode handles:

- proper indenting, generated by both [Tab] and [Return].
- color and font choices based on syntax.
- ability to send the contents of an entire buffer, a highlighted
  region, an S function, or a single line to an inferior S process, if
  one is currently running.
- ability to switch between processes which would be the target of the 
  buffer (for the above).
- The ability to request help from an S process for variables and
  functions, and to have the results sent into a separate buffer.
- completion of object names and file names.

ESS[S] mode should be automatically turned on when loading a file with
the suffices found in ess-site (*.R, *.S, *.s, etc).  However, one
will have to start up an inferior process to take advantage of the
interactive features.


iESS: Inferior ESS processes.
=============================

iESS (inferior ESS) is the mode for interfacing with active
statistical processes (programs).  This mode handles:

- proper indenting, generated by both [Tab] and [Return].
- color and font highlighting based on syntax.
- ability to resubmit the contents of a multi-line command
  to the executing process with a single keystroke [RET].
- The ability to request help from the current process for variables
  and functions, and to have the results sent into a separate buffer.
- completion of object names and file names.
- interactive history mechanism
- transcript recording and editing

To start up iESS mode, use:
   M-x S+3 
   M-x S4
   M-x R

(for S-PLUS 3.x, S4, and R, respectively.  This assumes that you have
access to each).  Usually the site will have defined one of these programs
(by default S+3) to the simpler name:

   M-x S

Note that R has some extremely useful command line arguments, 
-v and -n.   To enter these, call R using a "prefix argument", by

   C-u M-x R

and when ESS prompts for "Starting Args ? ", enter (for example):

   -v 10000 -n 5000

Then that R process will be started up using "R -v 10000 -n 5000".

New for ESS 5.1.2 (and later):  "S-elsewhere" command

  The idea of "M-x S-elsewhere" is that we open a telnet (or rlogin)
  to another machine, call the buffer "*S-elsewhere*", and then run S
  on the other machine in that buffer.  We do that by defining "sh" as
  the inferior-S-elsewhere-program-name.  Emacs sets it up in a
  "*S-elsewhere*" iESS buffer.  The user does a telnet or login from
  that buffer to the other machine and then starts S on the other
  machine.  The usual C-c C-n commands from myfile.s on the local
  machine get sent through the buffer "*S-elsewhere*" to be executed
  by S on the other machine.
                           

ESS-trans: Handling and Reusing Transcripts
===========================================

- edit transcript
- color and font highlighting based on syntax.
- resubmit multi-line commands to an active process buffer
- The ability to request help from an S process for variables and
  functions, and to have the results sent into a separate buffer.
- ability to switch between processes which would be the target of the 
  buffer (for the above).



ESS-help: assistance with viewing help
======================================

- move between help sections
- send examples to S for evaluation


Philosophies for using ESS
==========================

The first is preferred, and configured for.  The second one can be
retrieved again, by changing emacs variables.

1: (preferred by the current group of developers):  The source code is 
   real.  The objects are realizations of the source code.  Source
   for EVERY user modified object is placed in a particular directory
   or directories, for later editing and retrieval.

2: (older version): S objects are real.  Source code is a temporary
   realization of the objects.  Dumped buffers should not be saved.
   _We_strongly_discourage_this_approach_.  However, if you insist,
   add the following lines to your .emacs file:

      (setq ess-keep-dump-files 'nil)
      (setq ess-delete-dump-files t)
      (setq ess-mode-silently-save nil)

The second saves a small amount of disk space.  The first allows for
better portability as well as external version control for code.


Scenarios for use
=================

We present some basic suggestions for using ESS to interact with S.
These are just a subset of approaches, many better approaches are
possible.  Contributions of examples of how you work with ESS are
appreciated (especially since it helps us determine priorities on
future enhancements)! (comments as to what should be happening are
prefixed by "##").

1:  ##    Data Analysis Example (source code is real)
    ## Load the file you want to work with
    C-x C-f myfile.s

    ## Edit as appropriate, and then start up S-PLUS 3.x
    M-x S+3

    ## A new buffer *S+3:1* will appear.  Splus will have been started
    ## in this buffer.  The buffer is in iESS [S+3:1] mode.

    ## Split the screen and go back to the file editing buffer.
    C-x 2 C-x b myfile.s

    ## Send regions, lines, or the entire file contents to S-PLUS.  For regions,
    ## highlight a region with keystrokes or mouse and then send with:
    C-c C-r

    ## Re-edit myfile.s as necessary to correct any difficulties.  Add
    ## new commands here.  Send them to S by region with C-c C-r, or
    ## one line at a time with C-c C-n.

    ## Save the revised myfile.s with C-x C-s.

    ## Save the entire *S+3:1* interaction buffer with C-c C-s.  You
    ## will be prompted for a file name.  The recommended name is
    ## myfile.St.  With the *.St suffix, the file will come up in ESS
    ## Transcript mode the next time it is accessed from Emacs.



2:  ## Program revision example (source code is real)

    ## Start up S-PLUS 3.x in a process buffer (this will be *S+3:1*) 
    M-x S+3

    ## Load the file you want to work with
    C-x C-f myfile.s
    
    ## edit program, functions, and code in myfile.s, and send revised
    ## functions to S when ready with
    C-c C-f
    ## or highlighted regions with
    C-c C-r
    ## or individual lines with
    C-c C-n
    ## or load the entire buffer with 
    C-c C-l

    ## save the revised myfile.s when you have finished
    C-c C-s



3:  ## Program revision example (S object is real)

    ## Start up S-PLUS 3.x in a process buffer (this will be *S+3:1*) 
    M-x S+3

    ## Dump an existing S object my.function into a buffer to work with
    C-c C-d my.function
    ## a new buffer named yourloginname.my.function.S will be created with
    ## an editable copy of the object.  The buffer is associated with the
    ## pathname /tmp/yourloginname.my.function.S and will amlost certainly not
    ## exist after you log off.

    ## enter program, functions, and code into work buffer, and send
    ## entire contents to S-PLUS when ready
    C-c C-b

    ## Go to *S+3:1* buffer, which is the process buffer, and examine
    ## the results.
    C-c C-y
    ## The sequence C-c C-y is a shortcut for:  C-x b *S+3:1*

    ## Return to the work buffer (may/may not be prefixed)
    C-x C-b yourloginname.my.function.S
    ## Fix the function that didn't work, and resubmit by placing the
    ## cursor somewhere in the function and
    C-c C-f
    ## Or you could've selected a region (using the mouse, or keyboard 
    ## via setting point/mark) and 
    C-c C-r
    ## Or you could step through, line by line, using 
    C-c C-n
    ## Or just send a single line (without moving to the next) using
    C-c C-j
    ## To fix that error in syntax for the "rchisq" command, get help
    ## by
    C-c C-v rchisq


4:    Data Analysis (S object is real)
    ## Start up S-PLUS 3.x, in a process buffer (this will be *S+3:1*) 
    M-x S+3

    ## Work in the process buffer.  When you find an object that needs 
    ## to be changed (this could be a data frame, or a variable, or a 
    ## function), dump it to a buffer:
    C-c C-d my.cool.function

    ## Edit the function as appropriate, and dump back in to the
    ## process buffer  
    C-c C-b

    ## Return to the S-PLUS process buffer
    C-c C-y
    ## Continue working.

    ## When you need help, use 
    C-c C-v rchisq
    ## instead of entering:   help("rchisq")



Customization Examples and Solutions to Problems
================================================

1. Suppose that you are primarily an SPLUS 3.4 user, occasionally
   using S version 4, and sick and tired of the buffer-name *S+3*
   we've stuck you with.  Simply edit the "ess-dialect" alist entry in 
   the ess-s3-d.el and ess-s4-d.el files to be "S" instead of "S4" and
   "S+3".  This will insure that all the inferior process buffer names 
   are "*S*".

2. Suppose that you WANT to have the first buffer name indexed by
   ":1", in the same manner as your S-PLUS processes 2,3,4, and 5 (for
   you heavy simulation people).  Then uncomment the line in ess-site
   (or add after your (require 'ess-site) or (load "ess-site") command 
    in your .emacs file, the line:
       
       (setq ess-plain-first-buffername nil)
   )

3. Fontlocking sometimes fails to behave nicely upon errors.  When
   Splus dumps, a mis-matched "  (double-quote) can result in the
   wrong font-lock face being used for the remainder of the buffer.  

   Solution: add a " at the end of the "Dumped..." statement, to
   revert the font-lock face back to normal.
