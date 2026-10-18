package mvc.controler
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.Frame;
   import farm.FarmManager;
   import flash.utils.Dictionary;
   import managers.GloryroadManager;
   import managers.MountsManager;
   import managers.ShopManager;
   import managers.VIPManager;
   import mvc.FrameController;
   import mvc.module.fashion.FashionModel;
   import mvc.module.mounts.WildSoulInfo;
   import mvc.module.shop.ShopGoodsInfo;
   import mvc.module.shop.ShopModel;
   import mvc.module.vip.VIPModel;
   import yishi.datas.ConfigInfoManager;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.datas.templates.FurnitureShopTemplateInfo;
   import yishi.datas.templates.GoodsTemplateInfo;
   import yishi.datas.templates.MountTemplate;
   import yishi.manager.ArmyManager;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.SimpleDictionary;
   
   public class ShopControler extends FrameController
   {
      
      private var curMaxIndex:int;
      
      private var curA:int;
      
      private var curB:int;
      
      public function ShopControler()
      {
         super();
      }
      
      override protected function showFrame() : void
      {
         super.showFrame();
         if(_data.frameData)
         {
            _frame["show"](_data.frameData);
         }
         else
         {
            _frame["show"]();
         }
      }
      
      override public function get frameClassName() : String
      {
         if(_data.openType == 1)
         {
            return "view.ShopFrame";
         }
         if(_data.openType == 2)
         {
            return "consortia.ConsortiaShopFrame";
         }
         if(_data.openType == 3)
         {
            return "pvp.PvPShopFrame";
         }
         if(_data.openType == 4)
         {
            return "maze.MazeShopFrame";
         }
         if(_data.openType == 5)
         {
            return "consortia.ConsortiaFrame";
         }
         if(_data.openType == 6)
         {
            return "farm.FarmShopFrame";
         }
         if(_data.openType == 101)
         {
            return "star.StarShopFrame";
         }
         if(_data.openType == 8)
         {
            return "shop.FashionAllBuyFrame";
         }
         if(_data.openType == 9)
         {
            return "shop.LookFrame";
         }
         if(_data.openType == 16)
         {
            return "shop.BraveLegShopFrame";
         }
         if(_data.openType == 20)
         {
            return "shop.MatelordsShopFrame";
         }
         if(_data.openType == 1034)
         {
            return "shop.DungenexShopFrame";
         }
         if(_data.openType == 888)
         {
            return "shop.PetExchangeShopFrame";
         }
         if(_data.openType == 11)
         {
            return "mineral.MineralShopFrame";
         }
         if(_data.openType == 13)
         {
            return "shop.CrossPvPShopFrame";
         }
         if(_data.openType == 19)
         {
            return "shop.SvSShopFrame";
         }
         if(_data.openType == 1003)
         {
            return "shop.PokerShopFrame";
         }
         if(_data.openType == 1004)
         {
            return "shop.OutyardShopFrame";
         }
         if(_data.openType == 1005)
         {
            return "shop.BingoShopFrame";
         }
         if(_data.openType == 200)
         {
            return "shop.CartShopFrame";
         }
         if(_data.openType == 1002)
         {
            return "shop.MountShopFrame";
         }
         if(_data.openType == 9001)
         {
            return "shop.NavigationShopFrame";
         }
         if(_data.openType == 10)
         {
            return "shop.AresLordsShopFrame";
         }
         if(_data.openType == 1008)
         {
            return "view.subshop.GloryShopFrame";
         }
         if(_data.openType == 1010)
         {
            return "view.subshop.IsExploreShopFrame";
         }
         if(_data.openType == 1011)
         {
            return "view.subshop.AssaultwarShopFrame";
         }
         if(_data.openType == 1012)
         {
            return "shop.PumpingJoyShopFrame";
         }
         if(_data.openType == 35)
         {
            return "shop.GodsEveningShopFrame";
         }
         if(_data.openType == 1015)
         {
            return "shop.ApexShopFrame";
         }
         if(_data.openType == 1016)
         {
            return "shop.CrossGuildShopFrame";
         }
         if(_data.openType == 1017)
         {
            return "shop.AntaeusShopFrame";
         }
         if(_data.openType == 1018)
         {
            return "shop.AirGardenShopFrame";
         }
         if(_data.openType == 1019)
         {
            return "shop.WishPoolShopFrame";
         }
         if(_data.openType == 1020)
         {
            return "pvp.PvPShopFrame";
         }
         if(_data.openType == 1021)
         {
            return "pvp.PvPShopFrame";
         }
         if(_data.openType == 1022)
         {
            return "shop.DemonRoadShopFrame";
         }
         if(_data.openType == 1023)
         {
            return "shop.DarkMazeShopFrame";
         }
         if(_data.openType == 99999)
         {
            return "shop.ConsortiaNewBossBufferShopFrame";
         }
         if(_data.openType == 1024)
         {
            return "shop.ConsortiaNewBossShopFrame";
         }
         if(_data.openType == 1027)
         {
            return "shop.TheseuspvpShopFrame";
         }
         if(_data.openType == 1031)
         {
            return "shop.childnswarShopFrame";
         }
         return "view.ShopFrame";
      }
      
      override protected function exitFrame() : void
      {
         super.exitFrame();
      }
      
      public function openMountPreviewFrame() : void
      {
         var _loc1_:Frame = ComponentFactory.Instance.creatComponentByStylename("shop.MountPreviewFrame");
         _loc1_["show"]();
      }
      
      public function getShopFrame() : Boolean
      {
         if(_frame && _data.openType == 1)
         {
            return true;
         }
         return false;
      }
      
      public function closeFrame() : void
      {
         if(_frame && _data.openType == 888)
         {
            _frame.dispose();
         }
      }
      
      public function get model() : ShopModel
      {
         return ShopManager.Instance.model;
      }
      
      public function get frame() : Frame
      {
         return _frame;
      }
      
      public function searchGoods(param1:String) : void
      {
         var _loc4_:GoodsTemplateInfo = null;
         var _loc2_:Array = [];
         for each(var _loc3_:ShopGoodsInfo in model.allGoodsList)
         {
            _loc4_ = TempleteManager.instance.goodsTemplateCate.getTemplateByID(_loc3_.ItemId);
            if(_loc4_)
            {
               if(_loc3_.Area != 10)
               {
                  if(_loc3_.Area != 52)
                  {
                     if(_loc4_.TemplateName.indexOf(param1) != -1)
                     {
                        _loc2_.push(_loc3_);
                     }
                  }
               }
            }
         }
         setCurrentGoodsList(_loc2_);
      }
      
      private function get playerInfo() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
      }
      
      public function setCurrentGoodsList(param1:Array, param2:int = 9, param3:Boolean = true) : void
      {
         model.currentPageNum = param2;
         model.currentGoodsList = param1;
         if(param3)
         {
            model.currentPage = 1;
         }
         model.totalPage = Math.ceil(model.currentGoodsList.length / model.currentPageNum);
         model.showGoodsList = getShopShowList();
      }
      
      public function shopPageBtnHandler(param1:Boolean) : void
      {
         if(param1 && model.currentPage > 1)
         {
            model.currentPage--;
         }
         else
         {
            if(!(!param1 && model.currentPage < model.totalPage))
            {
               return;
            }
            model.currentPage++;
         }
         model.showGoodsList = getShopShowList();
      }
      
      public function initSvsShopFrame() : void
      {
         model.currentPage = 1;
         model.currentPageNum = 9;
         var _loc1_:Array = [];
         var _loc2_:int = thane.templateInfo.Job;
         for each(var _loc3_:ShopGoodsInfo in TempleteManager.instance.getSvsShopTempInfoList())
         {
            if(isJobFix(_loc2_,TempleteManager.instance.goodsTemplateCate.getTemplateByID(_loc3_.ItemId)))
            {
               _loc1_.push(_loc3_);
            }
         }
         _loc1_.sortOn(["NeedGeste","Sort"],16);
         model.totalPage = Math.ceil(_loc1_.length / model.currentPageNum);
         model.currentGoodsList = _loc1_;
         model.showGoodsList = getShopShowList();
      }
      
      private function getShopShowList() : Array
      {
         var _loc1_:int = (model.currentPage - 1) * model.currentPageNum;
         var _loc2_:int = _loc1_ + model.currentPageNum;
         if(_loc2_ > model.currentGoodsList.length)
         {
            _loc2_ = int(model.currentGoodsList.length);
         }
         return model.currentGoodsList.slice(_loc1_,_loc2_);
      }
      
      public function get mineralShopGoods() : Array
      {
         var _loc1_:Array = [];
         for each(var _loc2_:ShopGoodsInfo in TempleteManager.instance.getMineralShopTempInfoList())
         {
            _loc1_.push(_loc2_);
         }
         return _loc1_;
      }
      
      public function mineralShopGoodsSort(param1:ShopGoodsInfo, param2:ShopGoodsInfo) : int
      {
         var _loc3_:int = 0;
         if(param1.NeedMinGrade <= thane.grades && param2.NeedMinGrade <= thane.grades)
         {
            if(param1.MineScore < param2.MineScore)
            {
               _loc3_ = -1;
            }
            else if(param1.MineScore > param2.MineScore)
            {
               _loc3_ = 1;
            }
            else if(param1.MineScore == param2.MineScore)
            {
               _loc3_ = 0;
            }
         }
         else if(param1.NeedMinGrade < param2.NeedMinGrade)
         {
            _loc3_ = -1;
         }
         else if(param1.NeedMinGrade > param2.NeedMinGrade)
         {
            _loc3_ = 1;
         }
         else if(param1.NeedMinGrade == param2.NeedMinGrade)
         {
            if(param1.MineScore < param2.MineScore)
            {
               _loc3_ = -1;
            }
            else if(param1.MineScore > param2.MineScore)
            {
               _loc3_ = 1;
            }
            else if(param1.MineScore == param2.MineScore)
            {
               _loc3_ = 0;
            }
         }
         return _loc3_;
      }
      
      public function initConsortiaShopFrame() : void
      {
         model.currentPage = 1;
         model.currentPageNum = 9;
         var _loc1_:Array = [];
         for each(var _loc2_:ShopGoodsInfo in TempleteManager.instance.getConsortiaShopTempInfoList())
         {
            _loc1_.push(_loc2_);
         }
         _loc1_ = selectList(_loc1_);
         _loc1_.sortOn(["NeedConsortiaLevels","Sort"],[2 | 0x10,16]);
         model.totalPage = Math.ceil(_loc1_.length / model.currentPageNum);
         model.currentGoodsList = _loc1_;
         model.showGoodsList = getShopShowList();
      }
      
      public function initAdvConsortiaShopFrame() : void
      {
         model.currentPage = 1;
         model.currentPageNum = 9;
         var _loc1_:Array = [];
         for each(var _loc2_:ShopGoodsInfo in TempleteManager.instance.getAdvConsortiaShopTempInfoList())
         {
            _loc1_.push(_loc2_);
         }
         _loc1_ = selectList(_loc1_);
         _loc1_.sortOn(["NeedConsortiaLevels","Sort"],[2 | 0x10,16]);
         model.totalPage = Math.ceil(_loc1_.length / model.currentPageNum);
         model.currentGoodsList = _loc1_;
         model.showGoodsList = getShopShowList();
      }
      
      public function initTreasureConsortiaShopFrame() : void
      {
         model.currentPage = 1;
         model.currentPageNum = 9;
         var _loc1_:Array = [];
         for each(var _loc2_:ShopGoodsInfo in TempleteManager.instance.getTreasureConsortiaShopTempInfoList())
         {
            _loc1_.push(_loc2_);
         }
         _loc1_ = selectList(_loc1_);
         _loc1_.sortOn(["NeedConsortiaLevels","Sort"],[2 | 0x10,16]);
         model.totalPage = Math.ceil(_loc1_.length / model.currentPageNum);
         model.currentGoodsList = _loc1_;
         model.showGoodsList = getShopShowList();
      }
      
      public function initCopyConsortiaShopFrame() : void
      {
         model.currentPage = 1;
         model.currentPageNum = 9;
         var _loc1_:Array = [];
         for each(var _loc2_:ShopGoodsInfo in TempleteManager.instance.getCopyConsortiaShopTempInfoList())
         {
            _loc1_.push(_loc2_);
         }
         _loc1_ = selectList(_loc1_);
         _loc1_.sortOn(["NeedConsortiaLevels","Sort"],[2 | 0x10,16]);
         model.totalPage = Math.ceil(_loc1_.length / model.currentPageNum);
         model.currentGoodsList = _loc1_;
         model.showGoodsList = getShopShowList();
      }
      
      private function selectList(param1:Array) : Array
      {
         var _loc3_:Array = [];
         for each(var _loc2_:ShopGoodsInfo in param1)
         {
            if(_loc2_.NeedConsortiaLevels <= FrameControllerManager.instance.consortiaController.model.consortiaInfo.shopLevel + 1)
            {
               _loc3_.push(_loc2_);
            }
         }
         return _loc3_;
      }
      
      public function initFarmShopFrame() : void
      {
         var _loc12_:GoodsTemplateInfo = null;
         model.resetData(999,-1,-1);
         var _loc6_:Array = [];
         var _loc7_:Array = [];
         var _loc1_:int = 0;
         for each(var _loc13_:ShopGoodsInfo in model.farmShopTempArr)
         {
            if(_loc13_.NeedGrades <= FarmManager.instance.model.myFarm.grade)
            {
               _loc6_.push(_loc13_);
            }
            else if(_loc13_.NeedGrades - FarmManager.instance.model.myFarm.grade <= 5)
            {
               _loc7_.push(_loc13_);
            }
         }
         for each(var _loc14_:ShopGoodsInfo in _loc7_)
         {
            _loc6_.push(_loc14_);
         }
         _loc6_.sort(farmShopSortFunc);
         var _loc10_:SimpleDictionary = model.tabList;
         var _loc3_:Array = [];
         var _loc4_:Array = [];
         var _loc5_:Array = [];
         var _loc2_:Array = [];
         var _loc11_:Array = [];
         var _loc9_:Array = [];
         var _loc8_:Array = [];
         for each(_loc14_ in _loc6_)
         {
            _loc3_.push(_loc14_);
            switch((_loc12_ = TempleteManager.instance.goodsTemplateCate.getTemplateByID(_loc14_.ItemId)).Property2)
            {
               case -100:
                  _loc4_.push(_loc14_);
                  break;
               case -300:
                  _loc5_.push(_loc14_);
                  break;
               case -600:
                  _loc2_.push(_loc14_);
                  break;
               case -700:
                  _loc11_.push(_loc14_);
                  break;
               case 208001:
                  _loc9_.push(_loc14_);
                  _loc8_.push(_loc14_);
            }
         }
         _loc10_.add(1,_loc3_);
         _loc10_.add(2,_loc4_);
         _loc10_.add(3,_loc5_);
         _loc10_.add(4,_loc2_);
         _loc10_.add(5,_loc11_);
         _loc10_.add(7,_loc9_);
         _loc10_.add(6,_loc8_);
         model.currentTab = 1;
         _loc7_ = null;
      }
      
      private function farmShopSortFunc(param1:ShopGoodsInfo, param2:ShopGoodsInfo) : int
      {
         if(!param1 || !param2)
         {
            return 0;
         }
         if(param1.NeedGrades > param2.NeedGrades)
         {
            return -1;
         }
         if(param1.NeedGrades < param2.NeedGrades)
         {
            return 1;
         }
         return 0;
      }
      
      public function initFashionExchangeShop() : void
      {
         model.resetData(6,-1,-1);
         var _loc2_:SimpleDictionary = model.tabList;
         var _loc3_:Array = [];
         var _loc6_:Array = [];
         var _loc1_:Array = [];
         var _loc5_:Array = [];
         for each(var _loc4_:ShopGoodsInfo in TempleteManager.instance.getFashionExchangeShopTempInfoList())
         {
            switch(_loc4_.Area - 109)
            {
               case 0:
                  _loc5_.push(_loc4_);
                  break;
               case 1:
                  _loc1_.push(_loc4_);
                  break;
               case 2:
                  _loc3_.push(_loc4_);
                  break;
               case 3:
                  _loc6_.push(_loc4_);
            }
         }
         _loc3_ = sortList(_loc3_);
         _loc6_ = sortList(_loc6_);
         _loc1_ = sortList(_loc1_);
         _loc5_ = sortList(_loc5_);
         _loc2_.add(1,_loc3_);
         _loc2_.add(2,_loc6_);
         _loc2_.add(3,_loc1_);
         _loc2_.add(4,_loc5_);
         model.currentTab = 1;
      }
      
      public function sortList(param1:Array) : Array
      {
         var _loc19_:int = 0;
         var _loc25_:ShopGoodsInfo = null;
         var _loc20_:int = 0;
         var _loc21_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc9_:int = 0;
         var _loc16_:ShopGoodsInfo = null;
         var _loc3_:ShopGoodsInfo = null;
         var _loc2_:int = 0;
         var _loc17_:int = 0;
         var _loc8_:int = 0;
         var _loc23_:int = 0;
         var _loc11_:int = 0;
         var _loc24_:int = 0;
         var _loc4_:ShopGoodsInfo = null;
         var _loc18_:ShopGoodsInfo = null;
         var _loc10_:int = int(param1.length);
         var _loc15_:Array = [];
         var _loc13_:Array = [];
         var _loc12_:Array = [];
         var _loc22_:Array = [];
         var _loc14_:Array = [];
         _loc19_ = 0;
         while(_loc19_ < _loc10_)
         {
            _loc25_ = param1[_loc19_] as ShopGoodsInfo;
            if(fashionModel.isInBookList(_loc25_.ItemId))
            {
               _loc15_.push(_loc25_);
            }
            else
            {
               _loc13_.push(_loc25_);
            }
            _loc19_++;
         }
         _loc20_ = 0;
         while(_loc20_ < _loc15_.length)
         {
            _loc21_ = _loc15_.length - 1;
            while(_loc21_ > _loc20_)
            {
               _loc5_ = TempleteManager.instance.goodsTemplateCate.getTemplateByID((_loc15_[_loc21_] as ShopGoodsInfo).ItemId).TransformId;
               _loc6_ = TempleteManager.instance.goodsTemplateCate.getTemplateByID((_loc15_[_loc21_ - 1] as ShopGoodsInfo).ItemId).TransformId;
               _loc7_ = (_loc15_[_loc21_] as ShopGoodsInfo).ItemId;
               _loc9_ = (_loc15_[_loc21_ - 1] as ShopGoodsInfo).ItemId;
               if(_loc5_ < _loc6_)
               {
                  _loc16_ = _loc15_[_loc21_];
                  _loc15_[_loc21_] = _loc15_[_loc21_ - 1];
                  _loc15_[_loc21_ - 1] = _loc16_;
               }
               else if(_loc5_ == _loc6_)
               {
                  if(_loc7_ < _loc9_)
                  {
                     _loc3_ = _loc15_[_loc21_];
                     _loc15_[_loc21_] = _loc15_[_loc21_ - 1];
                     _loc15_[_loc21_ - 1] = _loc3_;
                  }
               }
               _loc21_--;
            }
            _loc20_++;
         }
         _loc2_ = 0;
         while(_loc2_ < _loc13_.length)
         {
            _loc17_ = _loc13_.length - 1;
            while(_loc17_ > _loc2_)
            {
               _loc8_ = TempleteManager.instance.goodsTemplateCate.getTemplateByID((_loc13_[_loc17_] as ShopGoodsInfo).ItemId).TransformId;
               _loc23_ = TempleteManager.instance.goodsTemplateCate.getTemplateByID((_loc13_[_loc17_ - 1] as ShopGoodsInfo).ItemId).TransformId;
               _loc11_ = (_loc13_[_loc17_] as ShopGoodsInfo).ItemId;
               _loc24_ = (_loc13_[_loc17_ - 1] as ShopGoodsInfo).ItemId;
               if(_loc8_ < _loc23_)
               {
                  _loc4_ = _loc13_[_loc17_];
                  _loc13_[_loc17_] = _loc13_[_loc17_ - 1];
                  _loc13_[_loc17_ - 1] = _loc4_;
               }
               else if(_loc8_ == _loc23_)
               {
                  if(_loc11_ < _loc24_)
                  {
                     _loc18_ = _loc13_[_loc17_];
                     _loc13_[_loc17_] = _loc13_[_loc17_ - 1];
                     _loc13_[_loc17_ - 1] = _loc18_;
                  }
               }
               _loc17_--;
            }
            _loc2_++;
         }
         return _loc13_.concat(_loc15_);
      }
      
      private function get fashionModel() : FashionModel
      {
         return FrameControllerManager.instance.fashionCodeController.model;
      }
      
      public function initMountExchangeShop() : void
      {
         model.resetData(6,-1,-1);
         var _loc2_:SimpleDictionary = model.tabList;
         var _loc1_:Array = [];
         var _loc3_:Array = [];
         for each(var _loc4_:ShopGoodsInfo in TempleteManager.instance.getMountExchangeShopTemplateDic())
         {
            switch(_loc4_.Area - 1)
            {
               case 0:
                  _loc3_.push(_loc4_);
                  break;
               case 1:
                  _loc1_.push(_loc4_);
            }
         }
         _loc1_.sort(sortMount);
         _loc3_.sort(sortMount);
         _loc2_.add(5,_loc1_);
         _loc2_.add(6,_loc3_);
         model.currentTab = 5;
      }
      
      private function sortMount(param1:ShopGoodsInfo, param2:ShopGoodsInfo) : int
      {
         var _loc5_:GoodsInfo = new GoodsInfo();
         _loc5_.templateId = param1.ItemId;
         var _loc4_:int = _loc5_.templateInfo.Property1;
         var _loc7_:GoodsInfo = new GoodsInfo();
         _loc7_.templateId = param2.ItemId;
         var _loc3_:int = _loc7_.templateInfo.Property1;
         var _loc8_:Dictionary = TempleteManager.instance.mountTemplateDic;
         var _loc6_:WildSoulInfo = MountsManager.instance.avatarList.getWildSoulInfo(_loc5_.templateInfo.Property1);
         var _loc9_:WildSoulInfo = MountsManager.instance.avatarList.getWildSoulInfo(_loc7_.templateInfo.Property1);
         if(_loc9_ && !_loc6_)
         {
            return -1;
         }
         if(!_loc9_ && _loc6_)
         {
            return 1;
         }
         if(!_loc6_ && !_loc9_ || _loc6_ && _loc9_)
         {
            if((_loc8_[_loc4_] as MountTemplate).Power < (_loc8_[_loc3_] as MountTemplate).Power)
            {
               return 1;
            }
            if((_loc8_[_loc4_] as MountTemplate).Power > (_loc8_[_loc3_] as MountTemplate).Power)
            {
               return -1;
            }
            return 0;
         }
         return 0;
      }
      
      public function initPokeShopFrame() : void
      {
         model.currentPage = 1;
         model.currentPageNum = 9;
         initPokeShopData();
         model.showGoodsList = getShopShowList();
      }
      
      private function initPokeShopData() : void
      {
         var _loc1_:Array = [];
         for each(var _loc2_:ShopGoodsInfo in model.shopTempDic[1003])
         {
            _loc1_.push(_loc2_);
         }
         model.totalPage = Math.ceil(_loc1_.length / model.currentPageNum);
         model.currentGoodsList = _loc1_;
      }
      
      public function initOutyardFrame() : void
      {
         model.currentPage = 1;
         model.currentPageNum = 9;
         initOutyardData();
         model.showGoodsList = getShopShowList();
      }
      
      private function initOutyardData() : void
      {
         var _loc1_:Array = [];
         for each(var _loc2_:ShopGoodsInfo in TempleteManager.instance.getOutyardTempInfoList())
         {
            _loc1_.push(_loc2_);
         }
         model.totalPage = Math.ceil(_loc1_.length / model.currentPageNum);
         model.currentGoodsList = _loc1_;
      }
      
      public function initBingoFrame() : void
      {
         model.currentPage = 1;
         model.currentPageNum = 9;
         initBingoData();
         model.showGoodsList = getShopShowList();
      }
      
      private function initBingoData() : void
      {
         var _loc1_:Array = [];
         for each(var _loc2_:ShopGoodsInfo in model.shopTempDic[1005])
         {
            _loc1_.push(_loc2_);
         }
         model.totalPage = Math.ceil(_loc1_.length / model.currentPageNum);
         model.currentGoodsList = _loc1_;
      }
      
      public function initPVPShopFrame(param1:int = 0) : void
      {
         model.currentPage = 1;
         model.currentPageNum = 9;
         if(param1 == 0)
         {
            initGoodsShopData();
         }
         else if(param1 == 1)
         {
            initFlameTempleShopData();
         }
         else if(param1 == 2)
         {
            initDuskAreaShopData();
         }
         else if(param1 == 3)
         {
            initScoreShopData();
         }
         model.showGoodsList = getShopShowList();
      }
      
      private function initGoodsShopData() : void
      {
         var _loc1_:Array = [];
         var _loc2_:int = thane.templateInfo.Job;
         for each(var _loc3_:ShopGoodsInfo in TempleteManager.instance.getAthleticsShopTempInfoList())
         {
            if(isJobFix(_loc2_,TempleteManager.instance.goodsTemplateCate.getTemplateByID(_loc3_.ItemId)))
            {
               _loc1_.push(_loc3_);
            }
         }
         _loc1_.sort(pvpShopSortFunc);
         model.totalPage = Math.ceil(_loc1_.length / model.currentPageNum);
         model.currentGoodsList = _loc1_;
      }
      
      private function initScoreShopData() : void
      {
         var _loc1_:Array = [];
         var _loc2_:int = thane.templateInfo.Job;
         for each(var _loc3_:ShopGoodsInfo in TempleteManager.instance.getScoreShopTempInfoList())
         {
            if(isJobFix(_loc2_,TempleteManager.instance.goodsTemplateCate.getTemplateByID(_loc3_.ItemId)))
            {
               _loc1_.push(_loc3_);
            }
         }
         _loc1_.sort(pvpShopSortFunc);
         model.totalPage = Math.ceil(_loc1_.length / model.currentPageNum);
         model.currentGoodsList = _loc1_;
      }
      
      private function initFlameTempleShopData() : void
      {
         var _loc1_:Array = [];
         var _loc2_:int = thane.templateInfo.Job;
         for each(var _loc3_:ShopGoodsInfo in TempleteManager.instance.getFlameTempleDic())
         {
            if(isJobFix(_loc2_,TempleteManager.instance.goodsTemplateCate.getTemplateByID(_loc3_.ItemId)))
            {
               _loc1_.push(_loc3_);
            }
         }
         _loc1_.sort(pvpShopSortFunc);
         model.totalPage = Math.ceil(_loc1_.length / model.currentPageNum);
         model.currentGoodsList = _loc1_;
      }
      
      private function initDuskAreaShopData() : void
      {
         var _loc1_:Array = [];
         var _loc2_:int = thane.templateInfo.Job;
         for each(var _loc3_:ShopGoodsInfo in TempleteManager.instance.getDuskAreaShopDic())
         {
            if(isJobFix(_loc2_,TempleteManager.instance.goodsTemplateCate.getTemplateByID(_loc3_.ItemId)))
            {
               _loc1_.push(_loc3_);
            }
         }
         _loc1_.sort(pvpShopSortFunc);
         model.totalPage = Math.ceil(_loc1_.length / model.currentPageNum);
         model.currentGoodsList = _loc1_;
      }
      
      private function pvpShopSortFunc(param1:ShopGoodsInfo, param2:ShopGoodsInfo) : int
      {
         var _loc4_:GoodsTemplateInfo = null;
         var _loc3_:GoodsTemplateInfo = null;
         if(thane.honer >= param1.NeedGeste && thane.honer >= param2.NeedGeste)
         {
            if(param1.Sort > 0 && param2.Sort > 0)
            {
               if(param1.Sort <= param2.Sort)
               {
                  return -1;
               }
               return 1;
            }
            if(param1.Sort == 0 && param2.Sort == 0)
            {
               _loc4_ = TempleteManager.instance.goodsTemplateCate.getTemplateByID(param1.ItemId);
               _loc3_ = TempleteManager.instance.goodsTemplateCate.getTemplateByID(param2.ItemId);
               if(!_loc4_ || !_loc3_)
               {
                  return 0;
               }
               if(_loc4_.MasterType == 3 && _loc3_.MasterType == 3)
               {
                  if(param1.NeedGeste >= param2.NeedGeste)
                  {
                     return -1;
                  }
                  return 1;
               }
               if(_loc4_.MasterType == 3 || _loc3_.MasterType == 3)
               {
                  if(_loc4_.MasterType == 3)
                  {
                     return -1;
                  }
                  return 1;
               }
               if(param1.NeedGeste > param2.NeedGeste)
               {
                  return -1;
               }
               if(param1.NeedGeste == param2.NeedGeste)
               {
                  if(_loc4_.Profile > _loc3_.Profile)
                  {
                     return -1;
                  }
                  if(_loc4_.Profile == _loc3_.Profile)
                  {
                     if(_loc4_.TemplateId < _loc3_.TemplateId)
                     {
                        return -1;
                     }
                  }
               }
               return 1;
            }
            if(param1.Sort > 0)
            {
               return -1;
            }
            if(param2.Sort > 0)
            {
               return 1;
            }
            return 0;
         }
         if(thane.honer >= param1.NeedGeste || thane.honer >= param2.NeedGeste)
         {
            if(thane.honer >= param1.NeedGeste)
            {
               return -1;
            }
            return 1;
         }
         if(param1.NeedGeste < param2.NeedGeste)
         {
            return -1;
         }
         if(param1.NeedGeste == param2.NeedGeste)
         {
            if(param1.ItemId > param2.ItemId)
            {
               return -1;
            }
         }
         return 1;
      }
      
      public function initWarlordsShopFrame() : void
      {
         model.currentPage = 1;
         model.currentPageNum = 9;
         var _loc1_:Array = [];
         var _loc2_:int = thane.templateInfo.Job;
         for each(var _loc3_:ShopGoodsInfo in TempleteManager.instance.getWarlordsShopTempInfoList())
         {
            if(isJobFix(_loc2_,TempleteManager.instance.goodsTemplateCate.getTemplateByID(_loc3_.ItemId)))
            {
               _loc1_.push(_loc3_);
            }
         }
         _loc1_.sortOn(["NeedGeste","Sort"],16);
         model.totalPage = Math.ceil(_loc1_.length / model.currentPageNum);
         model.currentGoodsList = _loc1_;
         model.showGoodsList = getShopShowList();
      }
      
      public function initBraveLegShopFrame() : void
      {
         model.currentPage = 1;
         model.currentPageNum = 9;
         var _loc1_:Array = [];
         var _loc2_:int = thane.templateInfo.Job;
         for each(var _loc3_:ShopGoodsInfo in TempleteManager.instance.getMultilordsShopTempInfoList())
         {
            if(isJobFix(_loc2_,TempleteManager.instance.goodsTemplateCate.getTemplateByID(_loc3_.ItemId)))
            {
               _loc1_.push(_loc3_);
            }
         }
         _loc1_.sortOn(["NeedGeste","Sort"],16);
         model.totalPage = Math.ceil(_loc1_.length / model.currentPageNum);
         model.currentGoodsList = _loc1_;
         model.showGoodsList = getShopShowList();
      }
      
      public function initMatelordsShopFrame() : void
      {
         model.currentPage = 1;
         model.currentPageNum = 9;
         var _loc1_:Array = [];
         var _loc2_:int = thane.templateInfo.Job;
         for each(var _loc3_:ShopGoodsInfo in TempleteManager.instance.getMatelordsShopTempInfoList())
         {
            if(isJobFix(_loc2_,TempleteManager.instance.goodsTemplateCate.getTemplateByID(_loc3_.ItemId)))
            {
               _loc1_.push(_loc3_);
            }
         }
         _loc1_.sortOn(["NeedGeste","Sort"],16);
         model.totalPage = Math.ceil(_loc1_.length / model.currentPageNum);
         model.currentGoodsList = _loc1_;
         model.showGoodsList = getShopShowList();
      }
      
      public function initThesepvpShopFrame(param1:int) : void
      {
         model.currentPage = 1;
         model.currentPageNum = 9;
         var _loc2_:Array = [];
         var _loc3_:int = thane.templateInfo.Job;
         var _loc5_:Dictionary = TempleteManager.instance.theseuspvpShopDic;
         for each(var _loc4_:ShopGoodsInfo in _loc5_)
         {
            if(_loc4_.Area == param1 && isJobFix(_loc3_,TempleteManager.instance.goodsTemplateCate.getTemplateByID(_loc4_.ItemId)))
            {
               _loc2_.push(_loc4_);
            }
         }
         _loc2_.sortOn(["NeedGeste","Sort"],16);
         model.totalPage = Math.ceil(_loc2_.length / model.currentPageNum);
         model.currentGoodsList = _loc2_;
         model.showGoodsList = getShopShowList();
      }
      
      public function initChildNsWarShopFrame(param1:int) : void
      {
         model.currentPage = 1;
         model.currentPageNum = 9;
         var _loc2_:Array = [];
         var _loc3_:int = thane.templateInfo.Job;
         var _loc5_:Dictionary = TempleteManager.instance.childNswarShopDic;
         for each(var _loc4_:ShopGoodsInfo in _loc5_)
         {
            if(_loc4_.Area == param1 && isJobFix(_loc3_,TempleteManager.instance.goodsTemplateCate.getTemplateByID(_loc4_.ItemId)))
            {
               _loc2_.push(_loc4_);
            }
         }
         _loc2_.sortOn(["NeedGeste","Sort"],16);
         model.totalPage = Math.ceil(_loc2_.length / model.currentPageNum);
         model.currentGoodsList = _loc2_;
         model.showGoodsList = getShopShowList();
      }
      
      public function initGodsEveningShopFrame() : void
      {
         model.currentPage = 1;
         model.currentPageNum = 9;
         var _loc1_:Array = [];
         var _loc2_:int = thane.templateInfo.Job;
         for each(var _loc3_:ShopGoodsInfo in TempleteManager.instance.getGodsEveningShopTempInfoList())
         {
            if(isJobFix(_loc2_,TempleteManager.instance.goodsTemplateCate.getTemplateByID(_loc3_.ItemId)))
            {
               _loc1_.push(_loc3_);
            }
         }
         _loc1_.sortOn(["NeedGeste","Sort"],16);
         model.totalPage = Math.ceil(_loc1_.length / model.currentPageNum);
         model.currentGoodsList = _loc1_;
         model.showGoodsList = getShopShowList();
      }
      
      public function initFurnitureShopFrame() : void
      {
         model.currentPage = 1;
         model.currentPageNum = 9;
         var _loc1_:Array = [];
         for each(var _loc2_:FurnitureShopTemplateInfo in TempleteManager.instance.furnitureShopTemplateCate.getTemplates())
         {
            _loc1_.push(_loc2_);
         }
         _loc1_.sortOn("Id",16);
         model.totalPage = Math.ceil(_loc1_.length / model.currentPageNum);
         model.currentGoodsList = _loc1_;
         model.showGoodsList = getShopShowList();
      }
      
      public function initAreslordsShopFrame() : void
      {
         model.currentPage = 1;
         model.currentPageNum = 9;
         var _loc1_:Array = [];
         var _loc2_:int = thane.templateInfo.Job;
         for each(var _loc3_:ShopGoodsInfo in TempleteManager.instance.getAreslordsShopTempInfoList())
         {
            if(isJobFix(_loc2_,TempleteManager.instance.goodsTemplateCate.getTemplateByID(_loc3_.ItemId)))
            {
               _loc1_.push(_loc3_);
            }
         }
         _loc1_.sortOn(["NeedGeste","Sort"],16);
         model.totalPage = Math.ceil(_loc1_.length / model.currentPageNum);
         model.currentGoodsList = _loc1_;
         model.showGoodsList = getShopShowList();
      }
      
      public function initDungenexShopFrame() : void
      {
         model.currentPage = 1;
         model.currentPageNum = 9;
         var _loc1_:Array = [];
         var _loc2_:int = thane.templateInfo.Job;
         for each(var _loc3_:ShopGoodsInfo in TempleteManager.instance.getdungenexShopTempInfoList())
         {
            if(isJobFix(_loc2_,TempleteManager.instance.goodsTemplateCate.getTemplateByID(_loc3_.ItemId)))
            {
               _loc1_.push(_loc3_);
            }
         }
         _loc1_.sortOn(["NeedGeste","Sort"],16);
         model.totalPage = Math.ceil(_loc1_.length / model.currentPageNum);
         model.currentGoodsList = _loc1_;
         model.showGoodsList = getShopShowList();
      }
      
      public function initApexShopFrame() : void
      {
         model.currentPage = 1;
         model.currentPageNum = 9;
         var _loc1_:Array = [];
         var _loc2_:int = thane.templateInfo.Job;
         for each(var _loc3_:ShopGoodsInfo in TempleteManager.instance.getApexShopTempInfoList())
         {
            if(isJobFix(_loc2_,TempleteManager.instance.goodsTemplateCate.getTemplateByID(_loc3_.ItemId)))
            {
               _loc1_.push(_loc3_);
            }
         }
         _loc1_.sortOn(["NeedGeste","Sort"],16);
         model.totalPage = Math.ceil(_loc1_.length / model.currentPageNum);
         model.currentGoodsList = _loc1_;
         model.showGoodsList = getShopShowList();
      }
      
      public function initAntaeusShopFrame() : void
      {
         model.currentPage = 1;
         model.currentPageNum = 9;
         var _loc1_:Array = [];
         var _loc2_:int = thane.templateInfo.Job;
         for each(var _loc3_:ShopGoodsInfo in TempleteManager.instance.getAntaeusShopTemplateDicList())
         {
            if(isJobFix(_loc2_,TempleteManager.instance.goodsTemplateCate.getTemplateByID(_loc3_.ItemId)))
            {
               _loc1_.push(_loc3_);
            }
         }
         _loc1_.sortOn(["NeedGeste","Sort"],16);
         model.totalPage = Math.ceil(_loc1_.length / model.currentPageNum);
         model.currentGoodsList = _loc1_;
         model.showGoodsList = getShopShowList();
      }
      
      public function initdDemonShopFrame() : void
      {
         model.currentPage = 1;
         model.currentPageNum = 9;
         var _loc1_:Array = [];
         var _loc2_:int = thane.templateInfo.Job;
         for each(var _loc3_:ShopGoodsInfo in TempleteManager.instance.getDemonShopTemplateDicList())
         {
            if(isJobFix(_loc2_,TempleteManager.instance.goodsTemplateCate.getTemplateByID(_loc3_.ItemId)))
            {
               _loc1_.push(_loc3_);
            }
         }
         _loc1_.sortOn(["NeedGeste","Sort"],16);
         model.totalPage = Math.ceil(_loc1_.length / model.currentPageNum);
         model.currentGoodsList = _loc1_;
         model.showGoodsList = getShopShowList();
      }
      
      public function initDarkMazeShopFrame() : void
      {
         model.currentPage = 1;
         model.currentPageNum = 9;
         var _loc1_:Array = [];
         var _loc2_:int = thane.templateInfo.Job;
         for each(var _loc3_:ShopGoodsInfo in TempleteManager.instance.getDarkMazeShopTemplateDicList())
         {
            if(isGradeFix(_loc3_) && isJobFix(_loc2_,TempleteManager.instance.goodsTemplateCate.getTemplateByID(_loc3_.ItemId)))
            {
               _loc1_.push(_loc3_);
            }
         }
         _loc1_.sortOn(["NeedGeste","Sort"],16);
         model.totalPage = Math.ceil(_loc1_.length / model.currentPageNum);
         model.currentGoodsList = _loc1_;
         model.showGoodsList = getShopShowList();
      }
      
      public function initGloryShopFrame() : void
      {
         var _loc2_:int = 0;
         var _loc4_:Dictionary = null;
         var _loc1_:Array = GloryroadManager.instance.model.getShopData();
         if(_loc1_.length == 0)
         {
            _loc2_ = thane.templateInfo.Job;
            _loc4_ = TempleteManager.instance.getGloryShopTempInfoList();
            for each(var _loc3_:ShopGoodsInfo in _loc4_)
            {
               if(isJobFix(_loc2_,TempleteManager.instance.goodsTemplateCate.getTemplateByID(_loc3_.ItemId)))
               {
                  _loc3_.ShopType = 1008;
                  _loc1_.push(_loc3_);
               }
            }
         }
      }
      
      public function initCrossGvgShopFrame() : void
      {
         model.currentPage = 1;
         model.currentPageNum = 9;
         var _loc1_:Array = [];
         var _loc2_:int = thane.templateInfo.Job;
         for each(var _loc3_:ShopGoodsInfo in TempleteManager.instance.getCrossGvgShopTempInfoList())
         {
            if(isJobFix(_loc2_,TempleteManager.instance.goodsTemplateCate.getTemplateByID(_loc3_.ItemId)))
            {
               _loc1_.push(_loc3_);
            }
         }
         _loc1_.sortOn(["NeedGeste","Sort"],16);
         model.totalPage = Math.ceil(_loc1_.length / model.currentPageNum);
         model.currentGoodsList = _loc1_;
         model.showGoodsList = getShopShowList();
      }
      
      public function initIsExploreShopFrame() : void
      {
         model.currentPage = 1;
         model.currentPageNum = 9;
         var _loc1_:Array = [];
         var _loc2_:int = thane.templateInfo.Job;
         for each(var _loc3_:ShopGoodsInfo in TempleteManager.instance.getIsExploreShopTempInfoList())
         {
            if(isJobFix(_loc2_,TempleteManager.instance.goodsTemplateCate.getTemplateByID(_loc3_.ItemId)))
            {
               _loc1_.push(_loc3_);
            }
         }
         _loc1_.sortOn(["NeedGeste","Sort"],16);
         model.totalPage = Math.ceil(_loc1_.length / model.currentPageNum);
         model.currentGoodsList = _loc1_;
         model.showGoodsList = getShopShowList();
      }
      
      public function initNewCrossGuildShopFrame() : void
      {
         model.currentPage = 1;
         model.currentPageNum = 9;
         var _loc1_:Array = [];
         var _loc2_:int = thane.templateInfo.Job;
         for each(var _loc3_:ShopGoodsInfo in TempleteManager.instance.getCrossGuildShopTempInfoList())
         {
            if(isJobFix(_loc2_,TempleteManager.instance.goodsTemplateCate.getTemplateByID(_loc3_.ItemId)))
            {
               _loc1_.push(_loc3_);
            }
         }
         _loc1_.sortOn(["NeedGeste","Sort"],16);
         model.totalPage = Math.ceil(_loc1_.length / model.currentPageNum);
         model.currentGoodsList = _loc1_;
         model.showGoodsList = getShopShowList();
      }
      
      public function initMazeShopFrame() : void
      {
         model.currentPage = 1;
         model.currentPageNum = 9;
         var _loc1_:Array = [];
         var _loc2_:int = thane.templateInfo.Job;
         for each(var _loc3_:ShopGoodsInfo in TempleteManager.instance.getMazeShopTempInfoList())
         {
            if(isJobFix(_loc2_,TempleteManager.instance.goodsTemplateCate.getTemplateByID(_loc3_.ItemId)))
            {
               _loc1_.push(_loc3_);
            }
         }
         _loc1_.sort(mazeShopSortFunc);
         model.totalPage = Math.ceil(_loc1_.length / model.currentPageNum);
         model.currentGoodsList = _loc1_;
         model.showGoodsList = getShopShowList();
      }
      
      public function initSevenYearShopFrame() : void
      {
         var _loc1_:Array = [];
         var _loc2_:int = thane.templateInfo.Job;
         for each(var _loc3_:ShopGoodsInfo in TempleteManager.instance.getSevenYearShopTemplateInfoList())
         {
            if(isJobFix(_loc2_,TempleteManager.instance.goodsTemplateCate.getTemplateByID(_loc3_.ItemId)))
            {
               _loc1_.push(_loc3_);
            }
         }
         _loc1_.sortOn(["NeedGeste","Sort"],16);
         model.currentGoodsList = _loc1_;
         model.showGoodsList = _loc1_;
      }
      
      public function inityearActiveShopFrame() : void
      {
         var _loc2_:Array = [];
         var _loc3_:int = thane.templateInfo.Job;
         var _loc1_:Array = TempleteManager.instance.yearActiveShopList;
         for each(var _loc4_:ShopGoodsInfo in _loc1_)
         {
            if(isJobFix(_loc3_,TempleteManager.instance.goodsTemplateCate.getTemplateByID(_loc4_.ItemId)))
            {
               _loc2_.push(_loc4_);
            }
         }
         _loc2_.sortOn(["NeedGeste","Sort"],16);
         model.currentGoodsList = _loc2_;
         model.showGoodsList = _loc2_;
      }
      
      private function mazeShopSortFunc(param1:ShopGoodsInfo, param2:ShopGoodsInfo) : int
      {
         var _loc4_:GoodsTemplateInfo = null;
         var _loc3_:GoodsTemplateInfo = null;
         if(PlayerManager.instance.currentPlayerModel.towerInfo2.maxIndex > 0)
         {
            curMaxIndex = PlayerManager.instance.currentPlayerModel.towerInfo2.maxIndex;
            curA = param1.MazeLayers2;
            curB = param2.MazeLayers2;
         }
         else
         {
            curMaxIndex = PlayerManager.instance.currentPlayerModel.towerInfo1.maxIndex;
            curA = param1.MazeLayers2 > 0 ? 100 : param1.MazeLayers;
            curB = param2.MazeLayers2 > 0 ? 100 : param2.MazeLayers;
         }
         if(curMaxIndex >= curA && curMaxIndex >= curB)
         {
            if(param1.Sort > 0 && param2.Sort > 0)
            {
               if(param1.Sort <= param2.Sort)
               {
                  return -1;
               }
               return 1;
            }
            if(param1.Sort == 0 && param2.Sort == 0)
            {
               if(param1.MazeLayers2 > param2.MazeLayers2)
               {
                  return -1;
               }
               if(param1.MazeLayers2 == param2.MazeLayers2)
               {
                  if(param1.MazeLayers > param2.MazeLayers)
                  {
                     return -1;
                  }
                  if(param1.MazeLayers == param2.MazeLayers)
                  {
                     _loc4_ = TempleteManager.instance.goodsTemplateCate.getTemplateByID(param1.ItemId);
                     _loc3_ = TempleteManager.instance.goodsTemplateCate.getTemplateByID(param2.ItemId);
                     if(!_loc4_ || !_loc3_)
                     {
                        return 0;
                     }
                     if(_loc4_.Profile > _loc3_.Profile)
                     {
                        return -1;
                     }
                     if(_loc4_.Profile == _loc3_.Profile)
                     {
                        if(_loc4_.TemplateId < _loc3_.TemplateId)
                        {
                           return -1;
                        }
                     }
                  }
               }
               return 1;
            }
            if(param1.Sort > 0)
            {
               return -1;
            }
            if(param2.Sort > 0)
            {
               return 1;
            }
            return 0;
         }
         if(curMaxIndex >= curA || curMaxIndex >= curB)
         {
            if(curMaxIndex >= curA)
            {
               return -1;
            }
            if(curMaxIndex >= curB)
            {
               return 1;
            }
            return 0;
         }
         if(param1.MazeLayers2 < param2.MazeLayers2)
         {
            return -1;
         }
         if(param1.MazeLayers2 == param2.MazeLayers2)
         {
            if(param1.MazeLayers < param2.MazeLayers)
            {
               return -1;
            }
            if(param1.MazeLayers == param2.MazeLayers)
            {
               if(param1.ItemId > param2.ItemId)
               {
                  return -1;
               }
            }
         }
         return 1;
      }
      
      public function initStarShopFrame() : void
      {
         model.currentPage = 1;
         model.currentPageNum = 6;
         var _loc1_:Array = TempleteManager.instance.starTempalteCate.getStarTemplatesByPoint(0,true);
         model.totalPage = Math.ceil(_loc1_.length / model.currentPageNum);
         model.currentGoodsList = _loc1_;
         model.showGoodsList = getShopShowList();
      }
      
      private function isJobFix(param1:int, param2:GoodsTemplateInfo) : Boolean
      {
         if(!param2)
         {
            return false;
         }
         var _loc3_:Array = param2.Job.split(",");
         for each(var _loc4_:int in _loc3_)
         {
            if(_loc4_ == 0 || _loc4_ == param1)
            {
               return true;
            }
         }
         return false;
      }
      
      private function isGradeFix(param1:ShopGoodsInfo) : Boolean
      {
         var _loc2_:Boolean = false;
         if(thane.isAvenger)
         {
            _loc2_ = true;
         }
         else if(thane.isChangeJob && param1.NeedMinGrade <= 161)
         {
            _loc2_ = true;
         }
         else if(thane.vocationGrades > 0 && thane.vocationIndex == 0 && param1.NeedMinGrade <= 81)
         {
            _loc2_ = true;
         }
         else if((thane.vocationGrades < 0 || thane.vocationGrades == 0) && param1.NeedMinGrade < 81)
         {
            _loc2_ = true;
         }
         return _loc2_;
      }
      
      private function get thane() : ThaneInfo
      {
         return ArmyManager.instance.thane;
      }
      
      public function initPetExchangeShopFrame(param1:int = 0) : void
      {
         model.currentPage = 1;
         model.currentPageNum = 6;
         var _loc2_:Array = [];
         var _loc4_:Dictionary = TempleteManager.instance.petExchangeShopTemplateDic;
         for each(var _loc3_:ShopGoodsInfo in _loc4_)
         {
            _loc2_.push(_loc3_);
         }
         _loc2_.sortOn("Sort",16);
         model.totalPage = Math.ceil(_loc2_.length / model.currentPageNum);
         model.currentGoodsList = _loc2_;
         model.showGoodsList = getShopShowList();
      }
      
      public function initSpiritShop() : void
      {
         model.currentPage = 1;
         model.currentPageNum = 6;
         var _loc1_:Array = [];
         var _loc3_:Dictionary = TempleteManager.instance.petExchangeShopTemplateDic;
         for each(var _loc2_:ShopGoodsInfo in _loc3_)
         {
            if(_loc2_.PayType == 1010)
            {
               _loc1_.push(_loc2_);
            }
         }
         _loc1_.sortOn("Sort",16);
         model.totalPage = Math.ceil(_loc1_.length / model.currentPageNum);
         model.currentGoodsList = _loc1_;
         model.showGoodsList = getShopShowList();
      }
      
      public function initEssenceShop() : void
      {
         model.currentPage = 1;
         model.currentPageNum = 6;
         var _loc1_:Array = [];
         var _loc3_:Dictionary = TempleteManager.instance.petExchangeShopTemplateDic;
         for each(var _loc2_:ShopGoodsInfo in _loc3_)
         {
            if(_loc2_.PayType == 1009)
            {
               _loc1_.push(_loc2_);
            }
         }
         _loc1_.sortOn("Sort",16);
         model.totalPage = Math.ceil(_loc1_.length / model.currentPageNum);
         model.currentGoodsList = _loc1_;
         model.showGoodsList = getShopShowList();
      }
      
      public function initBreathShop() : void
      {
         model.currentPage = 1;
         model.currentPageNum = 6;
         var _loc1_:Array = [];
         var _loc3_:Dictionary = TempleteManager.instance.petExchangeShopTemplateDic;
         for each(var _loc2_:ShopGoodsInfo in _loc3_)
         {
            if(_loc2_.PayType == 1011)
            {
               _loc1_.push(_loc2_);
            }
         }
         _loc1_.sortOn("Sort",16);
         model.totalPage = Math.ceil(_loc1_.length / model.currentPageNum);
         model.currentGoodsList = _loc1_;
         model.showGoodsList = getShopShowList();
      }
      
      public function initPetBossShopFrame() : void
      {
         model.currentPage = 1;
         model.currentPageNum = 6;
         var _loc1_:Array = [];
         var _loc3_:Dictionary = TempleteManager.instance.getPetBossShopTempInfoDic();
         for each(var _loc2_:ShopGoodsInfo in _loc3_)
         {
            _loc1_.push(_loc2_);
         }
         _loc1_.sortOn("Sort",16);
         model.totalPage = Math.ceil(_loc1_.length / model.currentPageNum);
         model.currentGoodsList = _loc1_;
         model.showGoodsList = getShopShowList();
      }
      
      public function initAssaultwarShopFrame() : void
      {
         model.currentPage = 1;
         model.currentPageNum = 9;
         var _loc1_:Array = [];
         var _loc2_:int = thane.templateInfo.Job;
         for each(var _loc3_:ShopGoodsInfo in TempleteManager.instance.getAssaultwarShopTempInfoList())
         {
            if(isJobFix(_loc2_,TempleteManager.instance.goodsTemplateCate.getTemplateByID(_loc3_.ItemId)))
            {
               _loc1_.push(_loc3_);
            }
         }
         _loc1_.sortOn(["NeedGeste","Sort"],16);
         model.totalPage = Math.ceil(_loc1_.length / model.currentPageNum);
         model.currentGoodsList = _loc1_;
         model.showGoodsList = getShopShowList();
      }
      
      public function initPumpingJoyShopFrame() : void
      {
         model.currentPage = 1;
         model.currentPageNum = 9;
         var _loc1_:Array = [];
         var _loc2_:int = thane.templateInfo.Job;
         for each(var _loc3_:ShopGoodsInfo in TempleteManager.instance.getPumpingJoyShopTempInfoList())
         {
            if(isJobFix(_loc2_,TempleteManager.instance.goodsTemplateCate.getTemplateByID(_loc3_.ItemId)))
            {
               _loc1_.push(_loc3_);
            }
         }
         _loc1_.sortOn(["NeedGeste","Sort"],16);
         model.totalPage = Math.ceil(_loc1_.length / model.currentPageNum);
         model.currentGoodsList = _loc1_;
         model.showGoodsList = getShopShowList();
      }
      
      public function initConsortiaNewBossBufferShopFrame() : void
      {
         model.currentPage = 1;
         model.currentPageNum = 9;
         var _loc1_:Array = ConfigInfoManager.instance.getConsortiaNewBossBufferData();
         _loc1_.sortOn("templateId",16);
         model.totalPage = Math.ceil(_loc1_.length / model.currentPageNum);
         model.currentGoodsList = _loc1_;
         model.showGoodsList = getShopShowList();
      }
      
      public function initConsortiaNewBossShopFrame() : void
      {
         model.currentPage = 1;
         model.currentPageNum = 9;
         var _loc1_:Array = [];
         var _loc2_:int = thane.templateInfo.Job;
         for each(var _loc3_:ShopGoodsInfo in TempleteManager.instance.getConsortiaNewBossShopTemplateDicList())
         {
            if(isJobFix(_loc2_,TempleteManager.instance.goodsTemplateCate.getTemplateByID(_loc3_.ItemId)))
            {
               _loc1_.push(_loc3_);
            }
         }
         _loc1_.sortOn(["NeedGeste","Sort"],16);
         model.totalPage = Math.ceil(_loc1_.length / model.currentPageNum);
         model.currentGoodsList = _loc1_;
         model.showGoodsList = getShopShowList();
      }
      
      public function initConsortiaMinosShopFrame() : void
      {
         model.currentPage = 1;
         model.currentPageNum = 9;
         var _loc1_:Array = [];
         var _loc2_:int = thane.templateInfo.Job;
         for each(var _loc3_:ShopGoodsInfo in TempleteManager.instance.minosShopDic)
         {
            if(isJobFix(_loc2_,TempleteManager.instance.goodsTemplateCate.getTemplateByID(_loc3_.ItemId)))
            {
               _loc1_.push(_loc3_);
            }
         }
         _loc1_.sortOn(["NeedGeste","Sort"],16);
         model.totalPage = Math.ceil(_loc1_.length / model.currentPageNum);
         model.currentGoodsList = _loc1_;
         model.showGoodsList = getShopShowList();
      }
      
      public function initConsortiaChessPvpShopFrame() : void
      {
         model.currentPage = 1;
         model.currentPageNum = 9;
         var _loc1_:Array = [];
         var _loc2_:int = thane.templateInfo.Job;
         for each(var _loc3_:ShopGoodsInfo in TempleteManager.instance.chesspvpShopDic)
         {
            if(isJobFix(_loc2_,TempleteManager.instance.goodsTemplateCate.getTemplateByID(_loc3_.ItemId)))
            {
               _loc1_.push(_loc3_);
            }
         }
         _loc1_.sortOn(["NeedGeste","Sort"],16);
         model.totalPage = Math.ceil(_loc1_.length / model.currentPageNum);
         model.currentGoodsList = _loc1_;
         model.showGoodsList = getShopShowList();
      }
      
      public function initVIPShopFrame() : void
      {
         model.currentPage = 1;
         model.currentPageNum = 6;
         var _loc1_:Array = [];
         var _loc3_:Dictionary = TempleteManager.instance.getVIPShopTemplateDic();
         for each(var _loc2_:ShopGoodsInfo in _loc3_)
         {
            _loc1_.push(_loc2_);
         }
         _loc1_.sort(vipShopSortFun);
         model.totalPage = Math.ceil(_loc1_.length / model.currentPageNum);
         model.currentGoodsList = _loc1_;
         model.showGoodsList = getShopShowList();
      }
      
      public function initthessboxShopFrame() : void
      {
         var _loc1_:Array = [];
         var _loc3_:Dictionary = TempleteManager.instance.getthessShopTemplateDic();
         for each(var _loc2_:ShopGoodsInfo in _loc3_)
         {
            _loc1_.push(_loc2_);
         }
         _loc1_.sortOn(["NeedGeste","Sort"],16);
      }
      
      private function get vipModel() : VIPModel
      {
         return VIPManager.Instance.model;
      }
      
      private function vipShopSortFun(param1:ShopGoodsInfo, param2:ShopGoodsInfo) : int
      {
         if(vipModel.vipInfo.VipShopLevel >= param1.NeedMinVip && vipModel.vipInfo.VipShopLevel >= param2.NeedMinVip)
         {
            if(param1.NeedMinVip < param2.NeedMinVip)
            {
               return -1;
            }
            if(param1.NeedMinVip == param2.NeedMinVip)
            {
               if(param1.Sort < param2.Sort)
               {
                  return -1;
               }
            }
            return 1;
         }
         if(vipModel.vipInfo.VipShopLevel >= param1.NeedMinVip || vipModel.vipInfo.VipShopLevel >= param2.NeedMinVip)
         {
            if(vipModel.vipInfo.VipShopLevel >= param1.NeedMinVip)
            {
               return -1;
            }
            return 1;
         }
         if(param1.NeedMinVip < param2.NeedMinVip)
         {
            return -1;
         }
         if(param1.NeedMinVip == param2.NeedMinVip)
         {
            if(param1.Sort < param2.Sort)
            {
               return -1;
            }
         }
         return 1;
      }
   }
}

