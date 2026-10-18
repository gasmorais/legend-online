package secretadventure.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.text.GradientText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import managers.DragonTalkerManager;
   import mvc.module.secret.SecretAdventureModel;
   import mvc.module.secret.SecretFrameInfo;
   import secretadventure.item.SecretAdProgressItem;
   import secretadventure.item.SecretAdventureItem;
   import yishi.datas.ConfigInfoManager;
   import yishi.datas.templates.ConfigInfosTempInfo;
   import yishi.datas.templates.RoyaltyTempInfo;
   import yishi.datas.templates.SecretMapLevelTemplate;
   import yishi.manager.PlayerManager;
   import yishi.manager.RechargeAlertMannager;
   import yishi.manager.RoyaltyBossManager;
   import yishi.manager.SecretAdventerManager;
   import yishi.manager.TempleteManager;
   import yishi.scene.SceneManager;
   import yishi.utils.SimpleAlertHelper;
   import yishi.view.base.HRollItemPanel;
   import yishi.view.tips.MessageTipManager;
   
   public class SecretAdRightView extends Sprite
   {
      
      public var _bg:Bitmap;
      
      public var _exporeBtn:IconButton;
      
      public var _restBtn:IconButton;
      
      public var _resetTime:FilterFrameText;
      
      public var _resetNum:FilterFrameText;
      
      public var _lvBoxs:HBox;
      
      private var _panel:HRollItemPanel;
      
      private var _cardName:GradientText;
      
      private var _restTxt:FilterFrameText;
      
      private var _info:SecretFrameInfo;
      
      private var _itemList:Array = [];
      
      private var _lvItemList:Array = [];
      
      public function SecretAdRightView()
      {
         super();
         initView();
         initEvent();
      }
      
      public function set info(param1:SecretFrameInfo) : void
      {
         var _loc2_:int = 0;
         var _loc3_:SecretAdventureItem = null;
         var _loc4_:int = 0;
         _info = param1;
         if(_info)
         {
            _restTxt.text = LanguageMgr.GetTranslation("secret.frame.leftTime",_info.remainingTimes);
            _restBtn.enable = _info.remainingTimes > 0;
            _loc2_ = int(_itemList.length);
            _loc4_ = 0;
            while(_loc4_ < _loc2_ - 1)
            {
               _loc3_ = _itemList[_loc4_];
               if(_loc3_ && _loc3_.temp && _loc3_.temp.MapId == _info.mapId)
               {
                  break;
               }
               _loc4_++;
            }
            if(_loc3_)
            {
               _loc3_.dispatchEvent(new MouseEvent("click"));
            }
         }
      }
      
      public function mapLvChang(param1:SecretMapLevelTemplate) : void
      {
         var _loc8_:int = 0;
         var _loc14_:RoyaltyTempInfo = null;
         var _loc11_:int = 0;
         var _loc12_:SecretAdventureItem = null;
         var _loc15_:int = 0;
         var _loc13_:Boolean = false;
         var _loc9_:Array = null;
         var _loc3_:int = 0;
         var _loc6_:int = 0;
         var _loc10_:SecretAdProgressItem = null;
         var _loc7_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:Boolean = false;
         _cardName.text = param1.MapName;
         if(_info)
         {
            _loc8_ = int(RoyaltyBossManager.instance.model.royaltyLevel);
            _loc14_ = TempleteManager.instance.royaltyTempCate.getTempInfoByLevel(_loc8_);
            _loc11_ = 0;
            if(_loc14_)
            {
               _loc11_ = int(_loc14_.OpenSecret);
            }
            for each(var _loc2_:SecretAdventureItem in _itemList)
            {
               if(_loc2_.temp)
               {
                  _loc15_ = int(_loc2_.temp.MapId);
                  if(_loc15_ <= _info.mapId)
                  {
                     if(_loc15_ <= _loc11_)
                     {
                        _loc2_.isLock = false;
                     }
                     else
                     {
                        _loc2_.isLock = true;
                     }
                  }
                  else
                  {
                     _loc2_.isLock = true;
                  }
                  _loc2_.isSelect = _loc15_ == param1.MapId;
                  if(_loc15_ == param1.MapId)
                  {
                     _loc12_ = _loc2_;
                  }
               }
            }
            _loc13_ = _loc12_.isLock;
            _loc9_ = param1.getSonList();
            _loc3_ = int(_loc9_.length);
            _loc6_ = int(_lvItemList.length);
            _lvBoxs.beginChanges();
            _lvBoxs.removeAllChild();
            _loc7_ = 0;
            while(_loc7_ < _loc3_)
            {
               if(_loc7_ < _loc6_)
               {
                  _loc10_ = _lvItemList[_loc7_];
               }
               else
               {
                  _loc10_ = new SecretAdProgressItem();
                  _lvItemList.push(_loc10_);
               }
               _loc10_.index = _loc7_ + 1;
               _loc10_.temp = _loc9_[_loc7_];
               if(_loc13_)
               {
                  _loc10_.updateCurrLv(0);
               }
               else
               {
                  _loc10_.updateCurrLv(_info.levelId);
               }
               _lvBoxs.addChild(_loc10_);
               _loc7_++;
            }
            _lvBoxs.commitChanges();
            _loc4_ = int(_loc9_[_loc3_ - 1].LevelId);
            _loc5_ = param1.MapId <= _loc11_;
            _loc5_ = _loc5_ && param1.MapId == _info.mapId;
            _loc5_ = _loc5_ && _info.levelId <= _loc4_;
            _exporeBtn.enable = _loc5_;
         }
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatBitmap("asset.secretad.bg");
         _exporeBtn = ComponentFactory.Instance.creatComponentByStylename("ui.secretadventure.exporeBtn");
         _restBtn = ComponentFactory.Instance.creatComponentByStylename("ui.secretadventure.restBtn");
         _resetTime = ComponentFactory.Instance.creatComponentByStylename("ui.secretadventure.resetTime");
         _resetNum = ComponentFactory.Instance.creatComponentByStylename("ui.secretadventure.resetNum");
         _cardName = ComponentFactory.Instance.creatComponentByStylename("ui.secretad.cardName");
         _lvBoxs = ComponentFactory.Instance.creatCustomObject("ui.secretadventure.lvBoxs");
         _restTxt = ComponentFactory.Instance.creatComponentByStylename("ui.secretadventure.resetTxt");
         _panel = new HRollItemPanel();
         _panel.initParams("ui.secretadventure.itemBoxs","ui.secretadventure.leftBtn","ui.secretadventure.rightBtn",4,149,328);
         addChild(_bg);
         addChild(_exporeBtn);
         addChild(_restBtn);
         addChild(_resetTime);
         addChild(_resetNum);
         addChild(_lvBoxs);
         addChild(_panel);
         addChild(_cardName);
         addChild(_restTxt);
         _exporeBtn.enable = false;
         _restBtn.enable = false;
         var _loc1_:Array = ConfigInfoManager.instance.getSecretyAdventureTime();
         var _loc4_:String = LanguageMgr.GetTranslation("secret.day.tip");
         var _loc5_:Array = _loc4_.split(",");
         var _loc2_:int = int(_loc1_[0]);
         var _loc3_:Array = _loc1_[1].split("|");
         _resetTime.text = LanguageMgr.GetTranslation("secret.frame.resetTime",_loc5_[_loc2_],_loc3_[0]);
         initItems();
         initLvs();
      }
      
      private function initItems() : void
      {
         var _loc2_:SecretAdventureItem = null;
         var _loc4_:int = 0;
         var _loc1_:Array = TempleteManager.instance.secretMapCate.getTempList();
         _loc1_.sortOn("MapId",16);
         var _loc3_:int = int(_loc1_.length);
         _loc4_ = 0;
         while(_loc4_ < _loc3_ + 1)
         {
            _loc2_ = ComponentFactory.Instance.creatCustomObject("ui.item.SecretAdventureItem");
            _itemList.push(_loc2_);
            if(_loc4_ < _loc3_)
            {
               _loc2_.temp = _loc1_[_loc4_];
            }
            else
            {
               _loc2_.temp = null;
            }
            _loc4_++;
         }
         _panel.updateList(_itemList);
      }
      
      private function initLvs() : void
      {
         var _loc1_:SecretAdProgressItem = null;
         var _loc2_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < 3)
         {
            _loc1_ = new SecretAdProgressItem();
            _lvItemList.push(_loc1_);
            _loc2_++;
         }
      }
      
      private function initEvent() : void
      {
         _exporeBtn.addEventListener("click",exploreHandler);
         _restBtn.addEventListener("click",restHandler);
      }
      
      private function removeEvent() : void
      {
         _exporeBtn.removeEventListener("click",exploreHandler);
         _restBtn.removeEventListener("click",restHandler);
      }
      
      private function restHandler(param1:MouseEvent) : void
      {
         var _loc2_:Array = null;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         var _loc5_:int = 100;
         var _loc6_:ConfigInfosTempInfo = TempleteManager.instance.getConfigInfoByConfigName("secretexplore_reset_times_cost_diamonds");
         if(_loc6_)
         {
            _loc2_ = _loc6_.ConfigValue.split(",");
            if(_info)
            {
               _loc7_ = int(_loc2_.length);
               _loc8_ = _loc7_ - _info.remainingTimes;
               _loc5_ = int(_loc2_[_loc8_]);
            }
         }
         var _loc3_:String = LanguageMgr.GetTranslation("public.confirm");
         var _loc4_:String = LanguageMgr.GetTranslation("public.cancel");
         var _loc9_:String = LanguageMgr.GetTranslation("public.prompt");
         var _loc10_:String = LanguageMgr.GetTranslation("secret.rest.point",_loc5_);
         SimpleAlertHelper.instance.data = [confromBack,_loc5_];
         SimpleAlertHelper.instance.popAlerFrame(_loc9_,_loc10_,_loc3_,_loc4_,false,true);
      }
      
      private function confromBack(param1:Boolean, param2:Boolean = false, param3:int = 100) : void
      {
         if(param1)
         {
            if(param3 > PlayerManager.instance.currentPlayerModel.playerInfo.point)
            {
               RechargeAlertMannager.show();
            }
            else
            {
               SecretAdventerManager.Instance.opCommon(8);
            }
         }
      }
      
      private function exploreHandler(param1:MouseEvent) : void
      {
         if(DragonTalkerManager.instance.model.isDragonTalker)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("secret.enter.tip"));
            return;
         }
         SecretAdventerManager.Instance.opCommon(6,_info.levelId);
         if(model.isTest)
         {
            SceneManager.instance.setScene("SECRET_ADVENTURE_SCENE");
         }
      }
      
      private function get model() : SecretAdventureModel
      {
         return SecretAdventerManager.Instance.model;
      }
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_exporeBtn);
         _exporeBtn = null;
         ObjectUtils.disposeObject(_restBtn);
         _restBtn = null;
         ObjectUtils.disposeObject(_resetTime);
         _resetTime = null;
         ObjectUtils.disposeObject(_resetNum);
         _resetNum = null;
         ObjectUtils.disposeObject(_lvBoxs);
         _lvBoxs = null;
         ObjectUtils.disposeObject(_cardName);
         _cardName = null;
         ObjectUtils.disposeObject(_restTxt);
         _restTxt = null;
         for each(var _loc1_:SecretAdventureItem in _itemList)
         {
            ObjectUtils.disposeObject(_loc1_);
         }
         _itemList = null;
         ObjectUtils.disposeObject(_panel);
         _panel = null;
         if(parent)
         {
            parent.removeChild(this);
         }
         _info = null;
      }
   }
}

