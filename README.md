sh-goodies
==========

A collection of bash shell scripts that I wrote.

#####Update 8/24/2014
  Added safe_rm and safe_rm_restore 

#####Safe RM project initial release notes
  The purpose of this script is to create a recycle bin for UNIX environment. Instead of deleting a file permanently using the command rm, safe_rm will stored it into a recycle bin and has the ability to restore the file to its original location using safe_rm_restore. This will recreate the entire directory structures if they do not exist.
  *  Create a recycle bin at $HOME/deleted (default).
    *  Recycle bin location can be customized by using $HOME/.rm.cfg or env variable $RMCFG. 
  *  To avoid name conflicts in the recycle bin, the file name is changed to the original name followed by an underscore and then followed by the inode. 
    *  For example, if a file named "f1" with inode 1234 were removed, the file would be named f1_1234 in the recycle bin.
  *  Original directory and filename are stored in $HOME/.restore.info
    *  Each line of this file contain the name of a stored file, followed by a colon, followed by the original full path and filename. 
    *  For example, if file f1 with inode 1234 were removed from the /home/usr1.name/ directory and another file named f1 with inode 5432 were removed from the /home/usr1.name/testing directory then .restore.info would contain:
      *  f1_1234:/home/usr1.name/f1
      *  f1_5432:/home/usr1.name/testing/f1
  *  To restore a file use safe_rm_restore 
    *  For example: safe_rm_restore f1_1234
  * Error checking
    *  Use "safe_rm" without a name of a file - error message
    *  Use "safe_rm file1" and file1 does not exist - error message
    *  Use "safe_rm dir1" and dir1 is a directory - error message
    *  Try to restore a file that does not exist in the recycle bin - error message
    *  If the restoring file already exists in the target directory, it will prompt "Do you want to overwrite?"
  *  safe_rm supports wildcards and option flags: -i for interactive, and -v for verbose, -r or -R to remove file(s) and directories recursively.
    *  Example:
      * safe_rm file1 file2 file3
      * safe_rm *
      * safe_rm -ivr *

