package avenger.view
{
   import avatar.view.ShowAvatar;
   import avenger.item.AvengerBodyPropItem;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.MovieImage;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import mvc.module.avenger.AvengerBodyInfo;
   import mvc.module.avenger.AvengerModel;
   import yishi.datas.templates.GoodsTemplateInfo;
   import yishi.manager.ArmyManager;
   import yishi.manager.AvengerManager;
   import yishi.manager.GoodsManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.MsgMan;
   import yishi.utils.NumberViewUtils;
   import yishi.view.base.ProgressCommon;
   import yishi.view.base.StarGroupView;
   import yishi.view.tips.MessageTipManager;
   
   public class AvengerBodyView extends Component
   {
      
      private var _inputText:FilterFrameText;
      
      private var _hasItemText:FilterFrameText;
      
      private var _liveValueText:FilterFrameText;
      
      private var _magicDefenceValueText:FilterFrameText;
      
      private var _defenceValue:FilterFrameText;
      
      private var _attackValueText:FilterFrameText;
      
      private var _nextPropItem:AvengerBodyPropItem;
      
      private var _curPropItem:AvengerBodyPropItem;
      
      private var _upgradeBtn:IconButton;
      
      private var _bodyBack:MutipleImage;
      
      private var _materialImage:Image;
      
      private var _heroAvatar:ShowAvatar;
      
      private var _effectCon:Component;
      
      private var _avengerEffect:MovieImage;
      
      private var _alertText:FilterFrameText;
      
      private var _starView:StarGroupView;
      
      private var _processImage:Bitmap;
      
      private var _maxImage:Image;
      
      private var _expBar:ProgressCommon;
      
      private var _numBit:BitmapData;
      
      private var _gradeCon:Component;
      
      private var hasMaterialCount:int;
      
      private var preAvengerDegree:int;
      
      public function AvengerBodyView()
      {
         super();
         initView();
         addEvent();
         refreshView();
      }
      
      private function initView() : void
      {
         _inputText = ComponentFactory.Instance.creatComponentByStylename("Avenger.AvengerBodyView.inputText");
         _hasItemText = ComponentFactory.Instance.creatComponentByStylename("Avenger.AvengerBodyView.hasItemText");
         _liveValueText = ComponentFactory.Instance.creatComponentByStylename("Avenger.AvengerBodyView.liveValueText");
         _magicDefenceValueText = ComponentFactory.Instance.creatComponentByStylename("Avenger.AvengerBodyView.magicDefenceValueText");
         _defenceValue = ComponentFactory.Instance.creatComponentByStylename("Avenger.AvengerBodyView.defenceValue");
         _attackValueText = ComponentFactory.Instance.creatComponentByStylename("Avenger.AvengerBodyView.attackValueText");
         _nextPropItem = ComponentFactory.Instance.creatCustomObject("Avenger.AvengerBodyView.nextPropItem");
         _curPropItem = ComponentFactory.Instance.creatCustomObject("Avenger.AvengerBodyView.curPropItem");
         _upgradeBtn = ComponentFactory.Instance.creatComponentByStylename("Avenger.AvengerBodyView.upgradeBtn");
         _bodyBack = ComponentFactory.Instance.creatComponentByStylename("Avenger.AvengerBodyView.bodyBack");
         _materialImage = ComponentFactory.Instance.creatComponentByStylename("AvengerBodyView.materialImage");
         _maxImage = ComponentFactory.Instance.creatComponentByStylename("AvengerBodyView.maxImage");
         _processImage = ComponentFactory.Instance.creatBitmap("asset.AvengerBodyView.processImage");
         _numBit = ComponentFactory.Instance.creatBitmapData("asset.Avenger.numBmd");
         _gradeCon = ComponentFactory.Instance.creatComponentByStylename("AvengerBodyView.gradeCon");
         _expBar = ComponentFactory.Instance.creatComponentByStylename("AvengerBodyView.expBar");
         _alertText = ComponentFactory.Instance.creatComponentByStylename("AvengerBodyView.alertText");
         _heroAvatar = new ShowAvatar(true);
         _heroAvatar.x = 50;
         _heroAvatar.y = 75;
         _heroAvatar.mouseChildren = _heroAvatar.mouseEnabled = false;
         _heroAvatar.data = ArmyManager.instance.thane;
         _starView = new StarGroupView();
         _starView.initParams("asset.common.grayStar2",28,"asset.common.lightStar2",28,10);
         _starView.x = 405;
         _starView.y = 265;
         addChild(_bodyBack);
         addChild(_processImage);
         addChild(_heroAvatar);
         addChild(_alertText);
         addChild(_gradeCon);
         addChild(_attackValueText);
         addChild(_defenceValue);
         addChild(_magicDefenceValueText);
         addChild(_liveValueText);
         addChild(_curPropItem);
         addChild(_nextPropItem);
         addChild(_maxImage);
         addChild(_starView);
         addChild(_expBar);
         addChild(_materialImage);
         addChild(_inputText);
         addChild(_hasItemText);
         addChild(_upgradeBtn);
         _inputText.text = "1";
         _maxImage.visible = false;
         this.mouseEnabled = false;
         _alertText.text = LanguageMgr.GetTranslation("AvengerBodyView.alertText.text");
      }
      
      private function addEvent() : void
      {
         _upgradeBtn.addEventListener("click",_upgradeBtnClickHandler);
         _inputText.addEventListener("change",__textChangHandler);
         MsgMan.addObserver("BODY_INFO_UPDATE",this,__onBodyInfoChangeHandler);
      }
      
      private function removeEvent() : void
      {
         if(_upgradeBtn)
         {
            _upgradeBtn.removeEventListener("click",_upgradeBtnClickHandler);
         }
         if(_inputText)
         {
            _inputText.removeEventListener("change",__textChangHandler);
         }
         MsgMan.removeObserver("BODY_INFO_UPDATE",this,__onBodyInfoChangeHandler);
      }
      
      private function __textChangHandler(param1:Event) : void
      {
         var _loc2_:int = parseInt(_inputText.text);
         var _loc3_:int = Math.min(hasMaterialCount,9999);
         if(_loc2_ <= 0)
         {
            _inputText.text = "1";
         }
         if(_loc2_ >= _loc3_)
         {
            _inputText.text = _loc3_ + "";
         }
      }
      
      private function _upgradeBtnClickHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         if(hasMaterialCount < int(_inputText.text) || int(_inputText.text) <= 0)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("PetHallowsRightSkillView.train.noGoodsAlert"));
            return;
         }
         if(!bodyInfo.nextTempInfo)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("map.campaign.view.ui.secretland.ConsortiaTreeExpView.maxLevel"));
            return;
         }
         AvengerManager.instance.sendAvengerBodyRequest(int(_inputText.text));
      }
      
      private function __onBodyInfoChangeHandler(param1:String, param2:Object) : void
      {
         refreshView();
      }
      
      private function refreshView() : void
      {
         var _loc4_:int = 0;
         NumberViewUtils.refreshValue(bodyInfo.tempInfo.BodyType,_gradeCon,_numBit,14,18,11,14,"0123456789");
         var _loc1_:Array = model.avengerBodyPropAry;
         _attackValueText.text = _loc1_[0] + "";
         _defenceValue.text = _loc1_[1] + "";
         _magicDefenceValueText.text = _loc1_[2] + "";
         _liveValueText.text = _loc1_[3] + "";
         var _loc2_:GoodsTemplateInfo = TempleteManager.instance.goodsTemplateCate.getTemplateByID(bodyInfo.tempInfo.NeedItem);
         _materialImage.tipData = _loc2_.TemplateName + ":" + _loc2_.Description;
         hasMaterialCount = GoodsManager.instance.getBagCountInPlayerAndStoneByTempId(bodyInfo.tempInfo.NeedItem);
         _hasItemText.text = LanguageMgr.GetTranslation("AvengerBodyView.hasItemText.text",hasMaterialCount);
         _curPropItem.data = bodyInfo.tempInfo;
         _nextPropItem.data = bodyInfo.nextTempInfo;
         if(bodyInfo.nextTempInfo)
         {
            _expBar.value = bodyInfo.exp / bodyInfo.tempInfo.NeedItemNum;
            _expBar.text = bodyInfo.exp + "/" + bodyInfo.tempInfo.NeedItemNum;
            _maxImage.visible = false;
         }
         else
         {
            _expBar.value = 1;
            _expBar.text = LanguageMgr.GetTranslation("armyII.viewII.rune.RuneUpgradeView.RuneMaxTxt");
            _maxImage.visible = true;
         }
         var _loc3_:int = bodyInfo.grade % 11;
         _starView.setStars(_loc3_);
         if((bodyInfo.grade + 1) % 11 == 0)
         {
            _upgradeBtn.iconStyle = "asset.Avenger.evolveBtn.icon";
            _upgradeBtn.iconInnerRectString = "53,44,13,22,13";
         }
         else
         {
            _upgradeBtn.iconStyle = "asset.Avenger.upgradeBtn.icon";
            _upgradeBtn.iconInnerRectString = "50,50,14,21,13";
         }
         if(preAvengerDegree != bodyInfo.degree)
         {
            if(_avengerEffect && _avengerEffect.parent)
            {
               _avengerEffect.parent.removeChild(_avengerEffect);
            }
            ObjectUtils.disposeObject(_avengerEffect);
            _avengerEffect = null;
            _loc4_ = Math.min(10,Math.ceil(bodyInfo.degree / 2));
            _avengerEffect = ComponentFactory.Instance.creatComponentByStylename("core.avengerEffectzs" + _loc4_);
            addChild(_avengerEffect);
            _avengerEffect.mouseChildren = _avengerEffect.mouseEnabled = false;
            _avengerEffect.x = 200;
            _avengerEffect.y = 320;
            _avengerEffect.movie.gotoAndPlay(1);
         }
         preAvengerDegree = bodyInfo.degree;
      }
      
      private function get bodyInfo() : AvengerBodyInfo
      {
         return AvengerManager.instance.model.bodyInfo;
      }
      
      private function get model() : AvengerModel
      {
         return AvengerManager.instance.model;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_inputText);
         _inputText = null;
         ObjectUtils.disposeObject(_hasItemText);
         _hasItemText = null;
         ObjectUtils.disposeObject(_liveValueText);
         _liveValueText = null;
         ObjectUtils.disposeObject(_magicDefenceValueText);
         _magicDefenceValueText = null;
         ObjectUtils.disposeObject(_defenceValue);
         _defenceValue = null;
         ObjectUtils.disposeObject(_attackValueText);
         _attackValueText = null;
         ObjectUtils.disposeObject(_nextPropItem);
         _nextPropItem = null;
         ObjectUtils.disposeObject(_curPropItem);
         _curPropItem = null;
         ObjectUtils.disposeObject(_upgradeBtn);
         _upgradeBtn = null;
         ObjectUtils.disposeObject(_bodyBack);
         _bodyBack = null;
         ObjectUtils.disposeObject(_materialImage);
         _materialImage = null;
         ObjectUtils.disposeObject(_gradeCon);
         _gradeCon = null;
         ObjectUtils.disposeObject(_numBit);
         _numBit = null;
         ObjectUtils.disposeObject(_expBar);
         _expBar = null;
         ObjectUtils.disposeObject(_maxImage);
         _maxImage = null;
         ObjectUtils.disposeObject(_alertText);
         _alertText = null;
         ObjectUtils.disposeObject(_starView);
         _starView = null;
         ObjectUtils.disposeObject(_heroAvatar);
         _heroAvatar = null;
         ObjectUtils.disposeObject(_processImage);
         _processImage = null;
         ObjectUtils.disposeObject(_avengerEffect);
         _avengerEffect = null;
         super.dispose();
      }
   }
}

