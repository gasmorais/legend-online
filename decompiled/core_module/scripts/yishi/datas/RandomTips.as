package yishi.datas
{
   import flash.utils.Dictionary;
   import manager.LanguageMgr;
   
   public class RandomTips
   {
      
      private static var _instance:RandomTips;
      
      public static const TIPS_NUM:int = 6;
      
      private var _tipsDic:Dictionary;
      
      public function RandomTips()
      {
         super();
         _tipsDic = new Dictionary();
         _tipsDic[1] = LanguageMgr.GetTranslation("yishi.datas.RandomTips.tips01");
         _tipsDic[2] = LanguageMgr.GetTranslation("yishi.datas.RandomTips.tips02");
         _tipsDic[3] = LanguageMgr.GetTranslation("yishi.datas.RandomTips.tips03");
         _tipsDic[4] = LanguageMgr.GetTranslation("yishi.datas.RandomTips.tips04");
         _tipsDic[5] = LanguageMgr.GetTranslation("yishi.datas.RandomTips.tips05");
         _tipsDic[6] = LanguageMgr.GetTranslation("yishi.datas.RandomTips.tips06");
         _tipsDic[7] = LanguageMgr.GetTranslation("yishi.datas.RandomTips.tips07");
         _tipsDic[8] = LanguageMgr.GetTranslation("yishi.datas.RandomTips.tips08");
         _tipsDic[9] = LanguageMgr.GetTranslation("yishi.datas.RandomTips.tips09");
         _tipsDic[10] = LanguageMgr.GetTranslation("yishi.datas.RandomTips.tips10");
         _tipsDic[11] = LanguageMgr.GetTranslation("yishi.datas.RandomTips.tips11");
      }
      
      public static function get instance() : RandomTips
      {
         if(!_instance)
         {
            _instance = new RandomTips();
         }
         return _instance;
      }
      
      public function getTip() : String
      {
         var _loc1_:int = int(Math.random() * 6) + 1;
         if(_tipsDic[_loc1_])
         {
            return _tipsDic[_loc1_];
         }
         return "";
      }
   }
}

