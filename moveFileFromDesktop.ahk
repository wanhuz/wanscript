

listExtension := "nds, ass, srt, ac3, epub, cia, 7z, exe, apk, iso, jar, rar, zip, aac, flac, mp3, wav, wma, c, cc, class, cpp, cs, cxx, h, java, py, xml, html, css, doc, docx, md, pdf, txt, bmp, gif, jpg, jpeg, png, psd, ai, eps, ps, svg, 3gp, avi, flv, mkv, mov, mp4, mpeg, mpg, srt, webm, wmv, csv, ppt, pptx"
listExtension := StrSplit(listExtension, ", ")

Loop % listExtension.MaxIndex() {
  MoveFile(listExtension[A_Index])

}

Loop Files, %A_Desktop%\*.*, D
{
    FolderString = %A_LoopFileName%
    Msgbox, % FolderString
    FileMoveDir, C:\Users\USER\Desktop\%FolderString%, C:\Users\USER\Documents\Desktop\%FolderString%
    if (ErrorLevel == 1)   ; i.e. it's not blank or zero.
      MsgBox, Unable to move %FolderString%. Check if the folder is in use or Folder already exist.
}

Msgbox, Moving file completed

MoveFile(extension) {

  Loop Files, %A_Desktop%\*.%extension%
  {
      FolderString = %A_LoopFileName%
      FileMove, C:\Users\USER\Desktop\%FolderString%, C:\Users\USER\Documents\Desktop\%FolderString%
      Msgbox, %A_LoopFileName% moved

  }

}
