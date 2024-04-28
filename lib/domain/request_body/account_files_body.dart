import 'dart:io';

class AccountFilesBody{
  File? commercialFile;
  File? taxFile;
  File? bannerFile;

  AccountFilesBody({this.commercialFile, this.taxFile, this.bannerFile});

  Map<String, dynamic> toJson() {
    if(commercialFile!=null){
      return {"commercial_id": commercialFile!.path};
    }else if(taxFile!=null){
      return {"tax": taxFile!.path};
    }else {
      return {"banner": bannerFile!.path};
    }
  }
}