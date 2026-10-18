package marry.income
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.FocusEvent;
   import flash.events.KeyboardEvent;
   import flash.utils.Dictionary;
   import manager.LanguageMgr;
   import managers.MarryManager;
   import mvc.module.friends.FriendItemCellInfo;
   import mvc.module.marry.MarryModel;
   import mvc.module.marry.MarrySender;
   import mvc.module.shop.ShopGoodsInfo;
   import yishi.datas.templates.GoodsTemplateInfo;
   import yishi.datas.templates.SkillPropertyTempInfo;
   import yishi.datas.templates.UpgradeTemplateInfo;
   import yishi.manager.ArmyManager;
   import yishi.manager.FriendManager;
   import yishi.manager.GoodsManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.CheckUIModuleUtil;
   import yishi.utils.MsgMan;
   import yishi.utils.NumberViewUtils;
   import yishi.view.base.Progress;
   import yishi.view.community.HeadIconCell;
   import yishi.view.frame.BuyFrameI;
   import yishi.view.tips.MessageTipManager;
   
   public class MarrySatisfactoryRateView extends Sprite implements Disposeable
   {
      
      private var _backGround:MutipleImage;
      
      private var _trainCount:FilterFrameText;
      
      private var _trainCountValue:FilterFrameText;
      
      private var _meiguizhenxin:FilterFrameText;
      
      private var _satisfactoryEXP:FilterFrameText;
      
      private var _satisfactoryLevel:FilterFrameText;
      
      private var _heartMask:Bitmap;
      
      private var _heartView:SatisfactoryHeartView;
      
      private var _satisfactoryLevelBack:ScaleFrameImage;
      
      private var _satisfactoryTitleImg:ScaleFrameImage;
      
      private var _satisfactoryLevelimg:ScaleFrameImage;
      
      private var _satisfactoryFrameTrainButton:BaseButton;
      
      private var _nowVbox:VBox;
      
      private var _dic:Dictionary;
      
      private var _progress:Progress;
      
      private var _mateRightView:MateRightView;
      
      private var _searchMateView:SearchMateView;
      
      private var _levelBmp:BitmapData;
      
      private var _container:Component;
      
      private var _selfIcon:HeadIconCell;
      
      private var _loverIcon:HeadIconCell;
      
      private var _needGoodsTemp:Array = [208034,208057];
      
      private var _heartComponent:Component;
      
      private var _nickNameA:FilterFrameText;
      
      private var _nickNameB:FilterFrameText;
      
      private var _propTipsContiner:Component;
      
      public function MarrySatisfactoryRateView()
      {
         super();
         initDic();
         initView();
         initEvent();
      }
      
      private function initDic() : void
      {
         _dic = new Dictionary();
         _dic["Power"] = LanguageMgr.GetTranslation("armyII.ThaneAttributeView.Tip01");
         _dic["Agility"] = LanguageMgr.GetTranslation("armyII.ThaneAttributeView.Tip02");
         _dic["Intellect"] = LanguageMgr.GetTranslation("armyII.ThaneAttributeView.Tip03");
         _dic["Physique"] = LanguageMgr.GetTranslation("armyII.ThaneAttributeView.Tip04");
         _dic["Captain"] = LanguageMgr.GetTranslation("armyII.ThaneAttributeView.Tip05");
         _dic["Attack"] = LanguageMgr.GetTranslation("armyII.ThaneAttributeView.Tip06");
         _dic["Defence"] = LanguageMgr.GetTranslation("armyII.ThaneAttributeView.Tip07");
         _dic["MagicAttack"] = LanguageMgr.GetTranslation("armyII.ThaneAttributeView.Tip08");
         _dic["MagicDefence"] = LanguageMgr.GetTranslation("armyII.ThaneAttributeView.Tip09");
         _dic["ForceHit"] = LanguageMgr.GetTranslation("armyII.ThaneAttributeView.Tip10");
         _dic["Live"] = LanguageMgr.GetTranslation("armyII.ThaneAttributeView.Tip11");
         _dic["Conat"] = LanguageMgr.GetTranslation("armyII.ThaneAttributeView.Tip17");
         _dic["Parry"] = LanguageMgr.GetTranslation("armyII.ThaneAttributeView.Tip19");
         _dic["Penetrate"] = LanguageMgr.GetTranslation("armyII.ThaneAttributeView.Tip25");
      }
      
      private function initView() : void
      {
         _heartComponent = ComponentFactory.Instance.creatCustomObject("marrySatisfactoryRateView.heartContainer");
         _backGround = ComponentFactory.Instance.creatComponentByStylename("marrySatisfactoryRateView.bg");
         _trainCount = ComponentFactory.Instance.creatComponentByStylename("marrySatisfactoryRateView.trainCount");
         _meiguizhenxin = ComponentFactory.Instance.creatComponentByStylename("marrySatisfactoryRateView.meiguizhenxin");
         _propTipsContiner = ComponentFactory.Instance.creatComponentByStylename("marrySatisfactoryRateView.propTipsContiner");
         _trainCountValue = ComponentFactory.Instance.creatComponentByStylename("core.InputTextStyle");
         _trainCountValue.selectable = true;
         _trainCountValue.x = 126;
         _trainCountValue.y = 326;
         _satisfactoryEXP = ComponentFactory.Instance.creatComponentByStylename("marrySatisfactoryRateView.satisfactoryEXP");
         _satisfactoryLevel = ComponentFactory.Instance.creatComponentByStylename("marrySatisfactoryRateView.satisfactoryLevel");
         _nickNameA = ComponentFactory.Instance.creatComponentByStylename("marrySatisfactoryRateView.nickNameText");
         _nickNameB = ComponentFactory.Instance.creatComponentByStylename("marrySatisfactoryRateView.nickNameText");
         _satisfactoryTitleImg = ComponentFactory.Instance.creatComponentByStylename("marrySatisfactoryFrame.titleImg");
         _satisfactoryLevelimg = ComponentFactory.Instance.creatComponentByStylename("marrySatisfactoryFrame.marrySatisfactoryLevel");
         _satisfactoryLevelBack = ComponentFactory.Instance.creatComponentByStylename("marry.marrySatisfactoryLevelBack");
         _satisfactoryFrameTrainButton = ComponentFactory.Instance.creatComponentByStylename("marrySatisfactoryFrame.trainButton");
         _nowVbox = ComponentFactory.Instance.creatComponentByStylename("MarryRingUpgradeFrame.nowVbox");
         _progress = ComponentFactory.Instance.creatComponentByStylename("MarryRingUpgradeFrame.progress");
         _levelBmp = ComponentFactory.Instance.creatBitmap("asset.marry.marrySatisfactoryLevelImg").bitmapData.clone();
         _container = ComponentFactory.Instance.creatCustomObject("MarryRingUpgradeFrame.levelContainer");
         _selfIcon = ComponentFactory.Instance.creatCustomObject("MarryHeartFrame.SelfCellHeadCell");
         _loverIcon = ComponentFactory.Instance.creatCustomObject("MarryHeartFrame.LoverCellHeadCell");
         _selfIcon.type = _loverIcon.type = "head";
         addChild(_backGround);
         addChild(_trainCount);
         addChild(_propTipsContiner);
         _propTipsContiner.addChild(_meiguizhenxin);
         addChild(_trainCountValue);
         addChild(_satisfactoryEXP);
         addChild(_satisfactoryLevel);
         addChild(_satisfactoryLevelBack);
         addChild(_container);
         addChild(_nowVbox);
         addChild(_selfIcon);
         addChild(_loverIcon);
         addChild(_nickNameA);
         addChild(_nickNameB);
         _nickNameB.x = 645;
         addChild(_satisfactoryTitleImg);
         addChild(_satisfactoryLevelimg);
         addChild(_satisfactoryFrameTrainButton);
         addChild(_progress);
         _progress.x = 30;
         _progress.y = 257;
         _trainCount.text = LanguageMgr.GetTranslation("marry.marrySatisfactoryRateView.trainCount");
         _heartView = new SatisfactoryHeartView();
         _heartComponent.addChild(_heartView);
         addChild(_heartComponent);
         _heartComponent.x = 344;
         _heartComponent.y = 65;
         _heartComponent.tipData = LanguageMgr.GetTranslation("marry.marrySatisfactoryRateView.happyDesc");
         _heartMask = ComponentFactory.Instance.creatBitmap("asset.marry.marryHeartMask");
         addChild(_heartMask);
         ___refresh();
      }
      
      private function setHeadIconCell() : void
      {
         _selfIcon.headId = ArmyManager.instance.thane.snsInfo.headId;
         _selfIcon.tipData = ArmyManager.instance.thane.nickName;
         var _loc1_:FriendItemCellInfo = FriendManager.getInstance().getFriendById(model.selfMarryInfo.userId) as FriendItemCellInfo;
         if(_loc1_)
         {
            _loverIcon.headId = _loc1_.snsInfo.headId;
            _loverIcon.tipData = model.selfMarryInfo.nickName;
         }
      }
      
      private function initEvent() : void
      {
         _trainCountValue.addEventListener("keyDown",__keydownHandler);
         _trainCountValue.addEventListener("change",__textChangHandler);
         _trainCountValue.addEventListener("focusIn",__inHandler);
         _satisfactoryFrameTrainButton.addEventListener("click",_satisfactoryFrameTrainButtonHandler);
         MsgMan.addObserver("MarryEventType.MARRIAGE_DATA",this,__infoUpdateHandler);
      }
      
      private function _satisfactoryFrameTrainButtonHandler(param1:Event) : void
      {
         if(int(_trainCountValue.text) <= 0)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("giftbag.GiftBagItem.noGoodsText"));
            return;
         }
         var _loc3_:int = int(model.marriageData.happyInfo.happyGrade >= 9 ? _needGoodsTemp[1] : _needGoodsTemp[0]);
         var _loc4_:int = int(GoodsManager.instance.getBagCountByTempId(1,_loc3_));
         var _loc2_:int = int(_trainCountValue.text);
         if(_loc4_ < _loc2_)
         {
            showQutiBuy(_loc3_,_loc2_ - _loc4_,_loc2_);
         }
         else
         {
            MarrySender.riseSatisfactory(_loc3_,_loc2_);
         }
      }
      
      private function showQutiBuy(param1:int, param2:int, param3:int) : void
      {
         var temapleteId:int = param1;
         var count:int = param2;
         var tatolCount:int = param3;
         var quickUIcallback:Function = function():void
         {
            var _loc1_:BuyFrameI = ComponentFactory.Instance.creatComponentByStylename("quickbuy.buyFrame");
            var _loc2_:ShopGoodsInfo = TempleteManager.instance.getShopInfoByItemIdAndArea(temapleteId,10);
            _loc1_.data(_loc2_,count,tatolCount);
            _loc1_.callback = buyCallBack;
            _loc1_.show();
         };
         CheckUIModuleUtil.instance.tryCall("quickbuy",quickUIcallback);
      }
      
      private function buyCallBack(param1:Boolean, param2:Object = null) : void
      {
         if(!param1)
         {
            return;
         }
         var _loc4_:int = int(param2);
         var _loc5_:int = int(model.marriageData.happyInfo.happyGrade >= 9 ? _needGoodsTemp[1] : _needGoodsTemp[0]);
         var _loc7_:String = model.marriageData.happyInfo.happyGrade >= 9 ? LanguageMgr.GetTranslation("marry.marrySatisfactoryRateView.eternityHeart") : LanguageMgr.GetTranslation("marry.marrySatisfactoryRateView.meiguizhenxin");
         var _loc6_:int = int(GoodsManager.instance.getBagCountByTempId(1,_loc5_));
         _meiguizhenxin.text = LanguageMgr.GetTranslation("marry.marrySatisfactoryRateView.meiguizhenxinCount",_loc6_,_loc7_);
         var _loc3_:GoodsTemplateInfo = TempleteManager.instance.goodsTemplateCate.getTemplateByID(_loc5_);
         _propTipsContiner.tipData = _loc3_.Description;
      }
      
      private function removeEvent() : void
      {
         if(_trainCountValue)
         {
            _trainCountValue.removeEventListener("keyDown",__keydownHandler);
         }
         if(_trainCountValue)
         {
            _trainCountValue.removeEventListener("change",__textChangHandler);
         }
         if(_trainCountValue)
         {
            _trainCountValue.removeEventListener("focusIn",__inHandler);
         }
         if(_satisfactoryFrameTrainButton)
         {
            _satisfactoryFrameTrainButton.removeEventListener("click",_satisfactoryFrameTrainButtonHandler);
         }
         MsgMan.removeObserver("MarryEventType.MARRIAGE_DATA",this,__infoUpdateHandler);
      }
      
      private function __keydownHandler(param1:KeyboardEvent) : void
      {
         param1.stopPropagation();
      }
      
      private function __textChangHandler(param1:Event) : void
      {
         if(int(_trainCountValue.text) > 9999)
         {
            _trainCountValue.text = "9999";
         }
      }
      
      private function __inHandler(param1:FocusEvent) : void
      {
         _trainCountValue.setSelection(0,_trainCountValue.text.length);
      }
      
      private function __infoUpdateHandler(param1:String, param2:Object) : void
      {
         ___refresh();
      }
      
      private function setRightView(param1:int) : void
      {
         if(param1 == 3)
         {
            if(!_mateRightView)
            {
               _mateRightView = new MateRightView();
               addChild(_mateRightView);
            }
         }
         else if(param1 == 4)
         {
            if(!_searchMateView)
            {
               _searchMateView = new SearchMateView();
               addChild(_searchMateView);
            }
            if(_mateRightView)
            {
               _mateRightView.dispose();
            }
            _mateRightView = null;
         }
      }
      
      private function refreshProgress() : void
      {
         _progress.setData(model.marriageData.happyInfo.happyGp,getnowInfo(model.marriageData.happyInfo.happyGrade).Data);
         if(_mateRightView)
         {
            _mateRightView.setData(model.marriageData,getnowInfo(model.marriageData.mateHappyInfo.happyGrade));
         }
      }
      
      private function ___refresh() : void
      {
         var _loc1_:int = 0;
         var _loc6_:SkillPropertyTempInfo = null;
         var _loc2_:FilterFrameText = null;
         setHeadIconCell();
         _nickNameA.text = ArmyManager.instance.thane.nickName;
         _nickNameB.text = model.selfMarryInfo.nickName == null ? "" : model.selfMarryInfo.nickName;
         if(model.marriangeState != 3)
         {
            _nickNameB.visible = false;
            _loverIcon.visible = false;
         }
         setRightView(model.marriangeState);
         var _loc10_:int = int(model.marriageData.happyInfo.happyGrade > model.marriageData.mateHappyInfo.happyGrade ? model.marriageData.mateHappyInfo.happyGrade : int(model.marriageData.happyInfo.happyGrade));
         _heartView.setLevel(_loc10_);
         NumberViewUtils.getNumberView(_loc10_,_container,_levelBmp,16,20,16,16,"0123456789",1);
         if(_loc10_ == 0)
         {
            _satisfactoryTitleImg.setFrame(1);
            _satisfactoryLevelimg.setFrame(1);
            _satisfactoryLevelBack.setFrame(1);
            _container.visible = false;
            _nowVbox.visible = false;
         }
         else if(_loc10_ < 9)
         {
            _satisfactoryTitleImg.setFrame(1);
            _satisfactoryLevelimg.setFrame(2);
            _satisfactoryLevelBack.setFrame(2);
            _nowVbox.visible = true;
            _container.visible = true;
         }
         else
         {
            _satisfactoryTitleImg.setFrame(2);
            _satisfactoryLevelimg.setFrame(3);
            _satisfactoryLevelBack.setFrame(2);
            _nowVbox.visible = true;
            _container.visible = true;
         }
         if(model.marriangeState == 4)
         {
            _satisfactoryTitleImg.setFrame(1);
            _satisfactoryLevelimg.setFrame(1);
            _satisfactoryLevelBack.setFrame(1);
            _container.visible = false;
            _nowVbox.visible = false;
         }
         _nowVbox.disposeAllChildren();
         var _loc3_:int = int(model.marriageData.ringInfo.ringGrade);
         var _loc12_:UpgradeTemplateInfo = getnowInfo(_loc10_ - 1);
         refreshProgress();
         var _loc7_:int = int(model.marriageData.happyInfo.happyGrade >= 9 ? _needGoodsTemp[1] : _needGoodsTemp[0]);
         var _loc9_:String = model.marriageData.happyInfo.happyGrade >= 9 ? LanguageMgr.GetTranslation("marry.marrySatisfactoryRateView.eternityHeart") : LanguageMgr.GetTranslation("marry.marrySatisfactoryRateView.meiguizhenxin");
         var _loc8_:int = int(GoodsManager.instance.getBagCountByTempId(1,_loc7_));
         _meiguizhenxin.text = LanguageMgr.GetTranslation("marry.marrySatisfactoryRateView.meiguizhenxinCount",_loc8_,_loc9_);
         var _loc4_:GoodsTemplateInfo = TempleteManager.instance.goodsTemplateCate.getTemplateByID(_loc7_);
         _propTipsContiner.tipData = _loc4_.Description;
         _satisfactoryFrameTrainButton.tipData = LanguageMgr.GetTranslation("marry.marrySatisfactoryRateView.trainneed",_loc9_);
         _trainCountValue.text = "1";
         var _loc5_:String = model.marriageData.happyInfo.happyGrade >= 9 ? LanguageMgr.GetTranslation("marry.marrySatisfactoryRateView.xinfudu") : LanguageMgr.GetTranslation("marry.marrySatisfactoryRateView.meimandu");
         _satisfactoryLevel.text = LanguageMgr.GetTranslation("marry.marrySatisfactoryRateView.marrySatisfactoryLevel",model.marriageData.happyInfo.happyGrade,_loc5_);
         _satisfactoryEXP.text = LanguageMgr.GetTranslation("marry.marrySatisfactoryRateView.marrySatisfactoryEXP",_loc5_);
         if(_loc12_)
         {
            _loc1_ = int(_loc12_.TemplateName);
            _loc6_ = TempleteManager.instance.skillPropertyTemplateCate.getTemplateByID(_loc1_);
            if(!_loc6_)
            {
               return;
            }
            for(var _loc11_:String in _dic)
            {
               if(_loc6_[_loc11_] > 0)
               {
                  _loc2_ = ComponentFactory.Instance.creatComponentByStylename("MarryRingUpgradeFrame.attributeTxt");
                  _loc2_.text = _dic[_loc11_] + ": + " + _loc6_[_loc11_];
                  _nowVbox.addChild(_loc2_);
               }
            }
         }
      }
      
      private function get model() : MarryModel
      {
         return MarryManager.instance.model;
      }
      
      private function getnowInfo(param1:int) : UpgradeTemplateInfo
      {
         var _loc2_:UpgradeTemplateInfo = TempleteManager.instance.getTemplateByLevelAndType(param1 + 1,35);
         while(_loc2_ == null)
         {
            param1 -= 1;
            _loc2_ = TempleteManager.instance.getTemplateByLevelAndType(param1 + 1,35);
            if(param1 < 0)
            {
               _loc2_ = new UpgradeTemplateInfo();
            }
         }
         return _loc2_;
      }
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeAllChildren(this);
         if(_nowVbox)
         {
            _nowVbox.dispose();
         }
         _nowVbox = null;
         ObjectUtils.disposeObject(_heartComponent);
         _heartComponent = null;
         ObjectUtils.disposeObject(_heartMask);
         _heartMask = null;
         ObjectUtils.disposeObject(_trainCount);
         _trainCount = null;
         ObjectUtils.disposeObject(_trainCount);
         _trainCount = null;
         ObjectUtils.disposeObject(_meiguizhenxin);
         _meiguizhenxin = null;
         ObjectUtils.disposeObject(_trainCountValue);
         _trainCountValue = null;
         ObjectUtils.disposeObject(_satisfactoryEXP);
         _satisfactoryEXP = null;
         ObjectUtils.disposeObject(_satisfactoryLevel);
         _satisfactoryLevel = null;
         ObjectUtils.disposeObject(_satisfactoryTitleImg);
         _satisfactoryTitleImg = null;
         ObjectUtils.disposeObject(_satisfactoryLevelimg);
         _satisfactoryLevelimg = null;
         ObjectUtils.disposeObject(_satisfactoryLevelBack);
         _satisfactoryLevelBack = null;
         ObjectUtils.disposeObject(_satisfactoryFrameTrainButton);
         _satisfactoryFrameTrainButton = null;
         _container;
         ObjectUtils.disposeObject(_container);
         _container = null;
         ObjectUtils.disposeObject(_selfIcon);
         _selfIcon = null;
         ObjectUtils.disposeObject(_nickNameA);
         _loverIcon = null;
         ObjectUtils.disposeObject(_nickNameB);
         _nickNameB = null;
         ObjectUtils.disposeObject(_propTipsContiner);
         _propTipsContiner = null;
         if(_heartView)
         {
            _heartView.dispose();
         }
         _heartView = null;
         if(_mateRightView)
         {
            _mateRightView.dispose();
         }
         _mateRightView = null;
         if(_searchMateView)
         {
            _searchMateView.dispose();
         }
         _searchMateView = null;
      }
   }
}

