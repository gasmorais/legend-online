package dragontalker
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import managers.DragonTalkerManager;
   import mvc.ModuleFrameInfo;
   import mvc.module.dragontalker.DragonTalkerModel;
   import mvc.module.dragontalker.DragonTalkerSymbioteInfo;
   import mvc.module.dragontalker.DragonTalkerTalismanInfo;
   import yishi.datas.ComponentGroupType;
   import yishi.datas.ConfigInfoManager;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.templates.GoodsTemplateInfo;
   import yishi.datas.templates.UpgradeTemplateInfo;
   import yishi.manager.GoodsManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.IconFactory;
   import yishi.utils.MsgMan;
   import yishi.view.community.BaseIconView;
   import yishi.view.community.BaseItemView;
   import yishi.view.community.BulePowerItem;
   import yishi.view.tips.MessageTipManager;
   
   public class DragonTalkerSymbioteUpgradeFrame extends Frame
   {
      
      private var _inputText:FilterFrameText;
      
      private var _costDescText:FilterFrameText;
      
      private var _hasMaterialText:FilterFrameText;
      
      private var _nextPropText:FilterFrameText;
      
      private var _curPropText:FilterFrameText;
      
      private var _gradeText:FilterFrameText;
      
      private var _inputBack:Image;
      
      private var _arrowImage:Image;
      
      private var _back:Image;
      
      private var _symbioteBtn:IconButton;
      
      private var _symbioteBack:ScaleFrameImage;
      
      private var _talismanBack:ScaleFrameImage;
      
      private var _equipText:FilterFrameText;
      
      private var _materialItem:BaseItemView;
      
      private var _talismanIcon:BaseIconView;
      
      private var _talismanProfileImage:ScaleFrameImage;
      
      private var _iconSprite:Sprite;
      
      private var _expBar:BulePowerItem;
      
      private var _addExpText:FilterFrameText;
      
      private var index:int = -1;
      
      private var curUpgradeTemp:UpgradeTemplateInfo;
      
      private var nextUpgradeTemp:UpgradeTemplateInfo;
      
      private var materialId:int;
      
      private var materialExp:int;
      
      private var hasMaterialCount:int;
      
      private var data:DragonTalkerSymbioteInfo;
      
      public function DragonTalkerSymbioteUpgradeFrame()
      {
         super();
         materialId = ConfigInfoManager.instance.getDragonTalkerInfoUpgradeConfig()[0];
         materialExp = ConfigInfoManager.instance.getDragonTalkerInfoUpgradeConfig()[1];
         initView();
         addEvent();
      }
      
      override public function get groups() : Array
      {
         return [ComponentGroupType.NONE];
      }
      
      private function initView() : void
      {
         _inputText = ComponentFactory.Instance.creatComponentByStylename("DragonTalker.n10_dtj6dtj62w");
         _costDescText = ComponentFactory.Instance.creatComponentByStylename("DragonTalker.n9_dtj6dtj62w");
         _hasMaterialText = ComponentFactory.Instance.creatComponentByStylename("DragonTalker.n8_dtj6dtj62w");
         _nextPropText = ComponentFactory.Instance.creatComponentByStylename("DragonTalker.n7_dtj6dtj62w");
         _curPropText = ComponentFactory.Instance.creatComponentByStylename("DragonTalker.n6_dtj6dtj62w");
         _gradeText = ComponentFactory.Instance.creatComponentByStylename("DragonTalker.n5_dtj6dtj62w");
         _inputBack = ComponentFactory.Instance.creatComponentByStylename("DragonTalker.dtj62w.inputBack");
         _arrowImage = ComponentFactory.Instance.creatComponentByStylename("DragonTalker.dtj62w.arrowImage");
         _back = ComponentFactory.Instance.creatComponentByStylename("DragonTalker.dtj62w.back");
         _symbioteBtn = ComponentFactory.Instance.creatComponentByStylename("DragonTalker.dtj62w.symbioteBtn");
         _symbioteBack = ComponentFactory.Instance.creatComponentByStylename("DragonTalker.dtj62w.symbioteBack");
         _talismanBack = ComponentFactory.Instance.creatComponentByStylename("DragonTalker.dtj62w.talismanBack");
         _equipText = ComponentFactory.Instance.creatComponentByStylename("DragonTalkerSymbioteUpgradeFrame.equipText");
         _talismanIcon = ComponentFactory.Instance.creatCustomObject("DragonTalkerSymbioteUpgradeFrame.icon");
         _talismanProfileImage = ComponentFactory.Instance.creatComponentByStylename("DragonTalkerSymbioteUpgradeFrame.profileImage");
         _expBar = ComponentFactory.Instance.creatCustomObject("DragonTalkerSymbioteUpgradeFrame.expBar",[true]);
         _materialItem = ComponentFactory.Instance.creatCustomObject("DragonTalkerSymbioteUpgradeFrame.materialItem");
         _addExpText = ComponentFactory.Instance.creatComponentByStylename("DragonTalkerSymbioteUpgradeFrame.addExpText");
         addToContent(_back);
         addToContent(_symbioteBack);
         addToContent(_equipText);
         addToContent(_arrowImage);
         addToContent(_talismanBack);
         addToContent(_talismanIcon);
         addToContent(_talismanProfileImage);
         addToContent(_gradeText);
         addToContent(_expBar);
         addToContent(_addExpText);
         addToContent(_curPropText);
         addToContent(_nextPropText);
         addToContent(_materialItem);
         addToContent(_hasMaterialText);
         addToContent(_costDescText);
         addToContent(_inputBack);
         addToContent(_inputText);
         addToContent(_symbioteBtn);
         _talismanProfileImage.mouseChildren = _talismanProfileImage.mouseEnabled = false;
         _talismanIcon.mask = createSprite();
         _costDescText.text = LanguageMgr.GetTranslation("DragonTalkerSymbioteUpgradeFrame.costDescText.text");
         var _loc1_:GoodsInfo = new GoodsInfo();
         _loc1_.templateId = materialId;
         _materialItem.data = _loc1_;
         _inputText.text = "1";
      }
      
      private function createSprite() : Sprite
      {
         _iconSprite = new Sprite();
         _iconSprite.graphics.beginFill(16777215,1);
         _iconSprite.graphics.drawCircle(289,119,27);
         _iconSprite.graphics.endFill();
         addToContent(_iconSprite);
         _iconSprite.mouseChildren = _iconSprite.mouseEnabled = false;
         return _iconSprite;
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__frameResponse);
         _inputText.addEventListener("change",__textChangHandler);
         _symbioteBtn.addEventListener("click",clicksymbioteBtnHandler);
         MsgMan.addObserver("DRAGON_TALKER_INFO_UPDATE",this,__updateSymbioteHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         if(_inputText)
         {
            _inputText.removeEventListener("change",__textChangHandler);
         }
         if(_symbioteBtn)
         {
            _symbioteBtn.removeEventListener("click",clicksymbioteBtnHandler);
         }
         MsgMan.removeObserver("DRAGON_TALKER_INFO_UPDATE",this,__updateSymbioteHandler);
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
         _addExpText.text = "+" + materialExp * int(_inputText.text);
      }
      
      private function clicksymbioteBtnHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         if(hasMaterialCount < int(_inputText.text) || int(_inputText.text) <= 0)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("PetHallowsRightSkillView.train.noGoodsAlert"));
            return;
         }
         DragonTalkerManager.instance.sendSymbiontStrengthReq(index,int(_inputText.text));
      }
      
      private function __updateSymbioteHandler(param1:String, param2:Object) : void
      {
         refreshView();
      }
      
      private function refreshView() : void
      {
         data = model.getSymbioteInfoByIndex(index);
         if(!data)
         {
            dispose();
            return;
         }
         var _loc1_:int = index + 1;
         _equipText.text = LanguageMgr.GetTranslation("DragonTalkerSymbioteUpgradeFrame.equipText.text") + LanguageMgr.GetTranslation("DragonTalkerBattleEquipInfoView.equipType.content" + _loc1_);
         _symbioteBack.setFrame(_loc1_);
         _symbioteBack.y = index == 2 || index == 5 ? 63 : 83;
         _equipText.y = _symbioteBack.y + 5;
         _talismanBack.setFrame(_loc1_);
         _gradeText.text = LanguageMgr.GetTranslation("public.level2",data.grade);
         curUpgradeTemp = model.symbioteUpgradeArr[data.grade - 1];
         nextUpgradeTemp = model.symbioteUpgradeArr[data.grade];
         _curPropText.text = LanguageMgr.GetTranslation("DragonTalkerSymbioteUpgradeFrame.curPropText.text",curUpgradeTemp.ActiveObject);
         var _loc3_:GoodsTemplateInfo = TempleteManager.instance.goodsTemplateCate.getTemplateByID(materialId);
         hasMaterialCount = GoodsManager.instance.getBagCountInPlayerAndStoneByTempId(materialId);
         _hasMaterialText.text = LanguageMgr.GetTranslation("DragonTalkerSymbioteUpgradeFrame.hasMaterialText.text",_loc3_.TemplateName,hasMaterialCount);
         var _loc2_:DragonTalkerTalismanInfo = model.getEquipTalismanInfoBySontype(index + 401);
         if(_loc2_)
         {
            _talismanProfileImage.visible = true;
            _talismanIcon.visible = true;
            _talismanIcon.icon = IconFactory.getGoodsIconByTID(_loc2_.goodsTempInfo.TemplateId);
            _talismanProfileImage.setFrame(_loc2_.goodsTempInfo.Profile);
         }
         else
         {
            _talismanProfileImage.visible = false;
            _talismanIcon.visible = true;
         }
         if(nextUpgradeTemp)
         {
            _symbioteBtn.enable = true;
            _nextPropText.text = LanguageMgr.GetTranslation("DragonTalkerSymbioteUpgradeFrame.nextPropText.text",nextUpgradeTemp.ActiveObject);
            _expBar.max = data.curMaxExp;
            _expBar.current = data.exp;
            _addExpText.text = "+" + materialExp * int(_inputText.text);
         }
         else
         {
            _symbioteBtn.enable = false;
            _nextPropText.text = "";
            _expBar.full = true;
            _expBar.setText("Max");
            _addExpText.text = "";
         }
      }
      
      private function __frameResponse(param1:FrameEvent) : void
      {
         switch(int(param1.responseCode))
         {
            case 0:
            case 1:
               dispose();
         }
      }
      
      public function show(param1:ModuleFrameInfo = null) : void
      {
         LayerManager.Instance.addToLayer(this,3,true,true,2);
         this.titleText = LanguageMgr.GetTranslation("DragonTalkerSymbioteUpgradeFrame.title.text");
         if(param1)
         {
            index = int(param1.frameData);
            refreshView();
         }
      }
      
      private function get model() : DragonTalkerModel
      {
         return DragonTalkerManager.instance.model;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_inputText);
         _inputText = null;
         ObjectUtils.disposeObject(_costDescText);
         _costDescText = null;
         ObjectUtils.disposeObject(_hasMaterialText);
         _hasMaterialText = null;
         ObjectUtils.disposeObject(_nextPropText);
         _nextPropText = null;
         ObjectUtils.disposeObject(_curPropText);
         _curPropText = null;
         ObjectUtils.disposeObject(_gradeText);
         _gradeText = null;
         ObjectUtils.disposeObject(_inputBack);
         _inputBack = null;
         ObjectUtils.disposeObject(_arrowImage);
         _arrowImage = null;
         ObjectUtils.disposeObject(_back);
         _back = null;
         ObjectUtils.disposeObject(_symbioteBtn);
         _symbioteBtn = null;
         ObjectUtils.disposeObject(_symbioteBack);
         _symbioteBack = null;
         ObjectUtils.disposeObject(_talismanBack);
         _talismanBack = null;
         ObjectUtils.disposeObject(_materialItem);
         _materialItem = null;
         ObjectUtils.disposeObject(_talismanIcon);
         _talismanIcon = null;
         ObjectUtils.disposeObject(_talismanProfileImage);
         _talismanProfileImage = null;
         ObjectUtils.disposeObject(_iconSprite);
         _iconSprite = null;
         ObjectUtils.disposeObject(_expBar);
         _expBar = null;
         ObjectUtils.disposeObject(_equipText);
         _equipText = null;
         ObjectUtils.disposeObject(_addExpText);
         _addExpText = null;
         super.dispose();
      }
   }
}

