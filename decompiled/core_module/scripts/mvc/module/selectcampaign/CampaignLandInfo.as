package mvc.module.selectcampaign
{
   import manager.LanguageMgr;
   import yishi.utils.SimpleDictionary;
   
   public class CampaignLandInfo
   {
      
      public var landId:int;
      
      private var _chapterDic:SimpleDictionary;
      
      private var _chapterCrackDic:SimpleDictionary;
      
      public function CampaignLandInfo()
      {
         super();
         _chapterDic = new SimpleDictionary(true);
         _chapterCrackDic = new SimpleDictionary(true);
      }
      
      public function addChapterInfo(param1:CampaignChapterInfo) : void
      {
         _chapterDic.add(param1.chapterId,param1);
      }
      
      public function addChapterCrackInfo(param1:CampaignChapterInfo) : void
      {
         _chapterCrackDic.add(param1.chapterId,param1);
      }
      
      public function clearChapterCrackDic() : void
      {
         for each(var _loc1_:CampaignChapterInfo in _chapterCrackDic)
         {
            _loc1_.areaDic.clear();
         }
      }
      
      public function getChapterCrackById(param1:int) : CampaignChapterInfo
      {
         return _chapterCrackDic[param1] as CampaignChapterInfo;
      }
      
      public function get chapterCrackDic() : SimpleDictionary
      {
         return _chapterCrackDic;
      }
      
      public function getChapterById(param1:int) : CampaignChapterInfo
      {
         return _chapterDic[param1] as CampaignChapterInfo;
      }
      
      public function get chapterDic() : SimpleDictionary
      {
         return _chapterDic;
      }
      
      public function getLandName() : String
      {
         switch(landId - 1)
         {
            case 0:
               return LanguageMgr.GetTranslation("selectcampaign.data.CampaignLandInfo.Name01");
            case 1:
               return LanguageMgr.GetTranslation("selectcampaign.data.CampaignLandInfo.Name02");
            case 2:
               return LanguageMgr.GetTranslation("selectcampaign.data.CampaignLandInfo.Name03");
            case 3:
               return LanguageMgr.GetTranslation("selectcampaign.data.CampaignLandInfo.Name04");
            default:
               return "";
         }
      }
   }
}

