package mvc.module.gameguide
{
   import manager.LanguageMgr;
   
   public class GameGuideModel
   {
      
      private var _expList:Array = [];
      
      private var _equipList:Array = [];
      
      private var _goldList:Array = [];
      
      private var _soulList:Array = [];
      
      private var _crystalList:Array = [];
      
      public function GameGuideModel()
      {
         super();
         initExpList();
         initEquipList();
         initGoldList();
         initSoulList();
         initCrystalList();
      }
      
      public function get expList() : Array
      {
         return _expList;
      }
      
      public function get equipList() : Array
      {
         return _equipList;
      }
      
      public function get goldList() : Array
      {
         return _goldList;
      }
      
      public function get soulList() : Array
      {
         return _soulList;
      }
      
      public function get crystalList() : Array
      {
         return _crystalList;
      }
      
      private function initExpList() : void
      {
         var _loc4_:GameGuideInfo = null;
         var _loc5_:GameGuideInfo = null;
         var _loc2_:GameGuideInfo = null;
         var _loc3_:GameGuideInfo = null;
         var _loc1_:GameGuideInfo = null;
         if(_expList.length <= 0)
         {
            _loc4_ = new GameGuideInfo();
            _loc4_.key = "EXP_GET_01";
            _loc4_.title = LanguageMgr.GetTranslation("gameguide.GameGuideModel.guideInfoTitle01");
            _loc4_.starCount = 5;
            _loc4_.describe = LanguageMgr.GetTranslation("gameguide.GameGuideModel.guideInfoDescribe01");
            _expList.push(_loc4_);
            _loc5_ = new GameGuideInfo();
            _loc5_.key = "EXP_GET_02";
            _loc5_.title = LanguageMgr.GetTranslation("gameguide.GameGuideModel.guideInfoTitle02");
            _loc5_.starCount = 5;
            _loc5_.describe = LanguageMgr.GetTranslation("gameguide.GameGuideModel.guideInfoDescribe02");
            _expList.push(_loc5_);
            _loc2_ = new GameGuideInfo();
            _loc2_.key = "EXP_GET_03";
            _loc2_.title = LanguageMgr.GetTranslation("gameguide.GameGuideModel.guideInfoTitle03");
            _loc2_.starCount = 5;
            _loc2_.describe = LanguageMgr.GetTranslation("gameguide.GameGuideModel.guideInfoDescribe03");
            _expList.push(_loc2_);
            _loc3_ = new GameGuideInfo();
            _loc3_.key = "EXP_GET_04";
            _loc3_.title = LanguageMgr.GetTranslation("gameguide.GameGuideModel.guideInfoTitle04");
            _loc3_.starCount = 4;
            _loc3_.describe = LanguageMgr.GetTranslation("gameguide.GameGuideModel.guideInfoDescribe04");
            _expList.push(_loc3_);
            _loc1_ = new GameGuideInfo();
            _loc1_.key = "EXP_GET_05";
            _loc1_.title = LanguageMgr.GetTranslation("gameguide.GameGuideModel.guideInfoTitle05");
            _loc1_.starCount = 4;
            _loc1_.describe = LanguageMgr.GetTranslation("gameguide.GameGuideModel.guideInfoDescribe05");
            _expList.push(_loc1_);
         }
      }
      
      private function initEquipList() : void
      {
         var _loc5_:GameGuideInfo = null;
         var _loc2_:GameGuideInfo = null;
         var _loc1_:GameGuideInfo = null;
         var _loc4_:GameGuideInfo = null;
         var _loc3_:GameGuideInfo = null;
         if(_equipList.length <= 0)
         {
            _loc5_ = new GameGuideInfo();
            _loc5_.key = "EQUIP_GET_01";
            _loc5_.title = LanguageMgr.GetTranslation("gameguide.GameGuideModel.guideInfoTitle06");
            _loc5_.starCount = 5;
            _loc5_.describe = LanguageMgr.GetTranslation("gameguide.GameGuideModel.guideInfoDescribe06");
            _equipList.push(_loc5_);
            _loc2_ = new GameGuideInfo();
            _loc2_.key = "EQUIP_GET_02";
            _loc2_.title = LanguageMgr.GetTranslation("gameguide.GameGuideModel.guideInfoTitle02");
            _loc2_.starCount = 5;
            _loc2_.describe = LanguageMgr.GetTranslation("gameguide.GameGuideModel.guideInfoDescribe07");
            _equipList.push(_loc2_);
            _loc1_ = new GameGuideInfo();
            _loc1_.key = "EQUIP_GET_03";
            _loc1_.title = LanguageMgr.GetTranslation("gameguide.GameGuideModel.guideInfoTitle04");
            _loc1_.starCount = 5;
            _loc1_.describe = LanguageMgr.GetTranslation("gameguide.GameGuideModel.guideInfoDescribe08");
            _equipList.push(_loc1_);
            _loc4_ = new GameGuideInfo();
            _loc4_.key = "EQUIP_GET_04";
            _loc4_.title = LanguageMgr.GetTranslation("gameguide.GameGuideModel.guideInfoTitle07");
            _loc4_.starCount = 5;
            _loc4_.describe = LanguageMgr.GetTranslation("gameguide.GameGuideModel.guideInfoDescribe09");
            _equipList.push(_loc4_);
            _loc3_ = new GameGuideInfo();
            _loc3_.key = "EQUIP_GET_05";
            _loc3_.title = LanguageMgr.GetTranslation("gameguide.GameGuideModel.guideInfoTitle05");
            _loc3_.starCount = 4;
            _loc3_.describe = LanguageMgr.GetTranslation("gameguide.GameGuideModel.guideInfoDescribe10");
            _equipList.push(_loc3_);
         }
      }
      
      private function initGoldList() : void
      {
         var _loc5_:GameGuideInfo = null;
         var _loc3_:GameGuideInfo = null;
         var _loc4_:GameGuideInfo = null;
         var _loc1_:GameGuideInfo = null;
         var _loc2_:GameGuideInfo = null;
         if(_goldList.length <= 0)
         {
            _loc5_ = new GameGuideInfo();
            _loc5_.key = "GOLD_GET_01";
            _loc5_.title = LanguageMgr.GetTranslation("gameguide.GameGuideModel.guideInfoTitle10");
            _loc5_.starCount = 5;
            _loc5_.describe = LanguageMgr.GetTranslation("gameguide.GameGuideModel.guideInfoDescribe12");
            _goldList.push(_loc5_);
            _loc3_ = new GameGuideInfo();
            _loc3_.key = "GOLD_GET_02";
            _loc3_.title = LanguageMgr.GetTranslation("gameguide.GameGuideModel.guideInfoTitle11");
            _loc3_.starCount = 5;
            _loc3_.describe = LanguageMgr.GetTranslation("gameguide.GameGuideModel.guideInfoDescribe13");
            _goldList.push(_loc3_);
            _loc4_ = new GameGuideInfo();
            _loc4_.key = "GOLD_GET_03";
            _loc4_.title = LanguageMgr.GetTranslation("gameguide.GameGuideModel.guideInfoTitle03");
            _loc4_.starCount = 5;
            _loc4_.describe = LanguageMgr.GetTranslation("gameguide.GameGuideModel.guideInfoDescribe14");
            _goldList.push(_loc4_);
            _loc1_ = new GameGuideInfo();
            _loc1_.key = "GOLD_GET_04";
            _loc1_.title = LanguageMgr.GetTranslation("gameguide.GameGuideModel.guideInfoTitle12");
            _loc1_.starCount = 4;
            _loc1_.describe = LanguageMgr.GetTranslation("gameguide.GameGuideModel.guideInfoDescribe15");
            _goldList.push(_loc1_);
            _loc2_ = new GameGuideInfo();
            _loc2_.key = "GOLD_GET_05";
            _loc2_.title = LanguageMgr.GetTranslation("gameguide.GameGuideModel.guideInfoTitle13");
            _loc2_.starCount = 3;
            _loc2_.describe = LanguageMgr.GetTranslation("gameguide.GameGuideModel.guideInfoDescribe16");
            _goldList.push(_loc2_);
         }
      }
      
      private function initSoulList() : void
      {
         var _loc3_:GameGuideInfo = null;
         var _loc4_:GameGuideInfo = null;
         var _loc1_:GameGuideInfo = null;
         var _loc2_:GameGuideInfo = null;
         if(_soulList.length <= 0)
         {
            _loc3_ = new GameGuideInfo();
            _loc3_.key = "SOUL_GET_01";
            _loc3_.title = LanguageMgr.GetTranslation("gameguide.GameGuideModel.guideInfoTitle17");
            _loc3_.starCount = 5;
            _loc3_.describe = LanguageMgr.GetTranslation("gameguide.GameGuideModel.guideInfoDescribe20");
            _soulList.push(_loc3_);
            _loc4_ = new GameGuideInfo();
            _loc4_.key = "SOUL_GET_02";
            _loc4_.title = LanguageMgr.GetTranslation("gameguide.GameGuideModel.guideInfoTitle11");
            _loc4_.starCount = 5;
            _loc4_.describe = LanguageMgr.GetTranslation("gameguide.GameGuideModel.guideInfoDescribe21");
            _soulList.push(_loc4_);
            _loc1_ = new GameGuideInfo();
            _loc1_.key = "SOUL_GET_03";
            _loc1_.title = LanguageMgr.GetTranslation("gameguide.GameGuideModel.guideInfoTitle03");
            _loc1_.starCount = 5;
            _loc1_.describe = LanguageMgr.GetTranslation("gameguide.GameGuideModel.guideInfoDescribe22");
            _soulList.push(_loc1_);
            _loc2_ = new GameGuideInfo();
            _loc2_.key = "SOUL_GET_04";
            _loc2_.title = LanguageMgr.GetTranslation("gameguide.GameGuideModel.guideInfoTitle18");
            _loc2_.starCount = 4;
            _loc2_.describe = LanguageMgr.GetTranslation("gameguide.GameGuideModel.guideInfoDescribe23");
            _soulList.push(_loc2_);
         }
      }
      
      private function initCrystalList() : void
      {
         var _loc3_:GameGuideInfo = null;
         var _loc1_:GameGuideInfo = null;
         var _loc2_:GameGuideInfo = null;
         if(_crystalList.length <= 0)
         {
            _loc3_ = new GameGuideInfo();
            _loc3_.key = "CRYSTAL_GET_01";
            _loc3_.title = LanguageMgr.GetTranslation("gameguide.GameGuideModel.guideInfoTitle03");
            _loc3_.starCount = 5;
            _loc3_.describe = LanguageMgr.GetTranslation("gameguide.GameGuideModel.guideInfoDescribe26");
            _crystalList.push(_loc3_);
            _loc1_ = new GameGuideInfo();
            _loc1_.key = "CRYSTAL_GET_02";
            _loc1_.title = LanguageMgr.GetTranslation("gameguide.GameGuideModel.guideInfoTitle21");
            _loc1_.starCount = 4;
            _loc1_.describe = LanguageMgr.GetTranslation("gameguide.GameGuideModel.guideInfoDescribe27");
            _crystalList.push(_loc1_);
            _loc2_ = new GameGuideInfo();
            _loc2_.key = "CRYSTAL_GET_03";
            _loc2_.title = LanguageMgr.GetTranslation("gameguide.GameGuideModel.guideInfoTitle12");
            _loc2_.starCount = 4;
            _loc2_.describe = LanguageMgr.GetTranslation("gameguide.GameGuideModel.guideInfoDescribe28");
            _crystalList.push(_loc2_);
         }
      }
   }
}

