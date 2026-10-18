package pethallows
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.utils.getTimer;
   import manager.LanguageMgr;
   import mvc.module.pet.pethallows.PetHallowsModel;
   import yishi.datas.ComponentGroupType;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.datas.templates.PetContracTemplateInfo;
   import yishi.datas.templates.PetTemplate;
   import yishi.filter.UIFilter;
   import yishi.manager.ArmyManager;
   import yishi.manager.GoodsManager;
   import yishi.manager.PetHallowsManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.IconFactory;
   import yishi.utils.MsgMan;
   import yishi.view.community.BaseIconView;
   import yishi.view.tips.MessageTipManager;
   
   public class PetContracUpgradeFrame extends Frame
   {
      
      private var back:MutipleImage;
      
      private var addAttImage:Image;
      
      private var alertText1:FilterFrameText;
      
      private var alertText2:FilterFrameText;
      
      private var needText:FilterFrameText;
      
      private var hasText:FilterFrameText;
      
      private var contracBtn:IconButton;
      
      private var upgradeMc:MovieClip;
      
      private var petBack:Image;
      
      private var petIcon:BaseIconView;
      
      private var petSprite:Sprite;
      
      private var propAddContiner:Component;
      
      private var addArrow:Bitmap;
      
      private var addPropText:FilterFrameText;
      
      private var addValueText:FilterFrameText;
      
      private var _filter:UIFilter;
      
      private var _data:PetContracTemplateInfo;
      
      private var curTempId:int;
      
      private var curTempInfo:PetContracTemplateInfo;
      
      private var nextTempInfo:PetContracTemplateInfo;
      
      private var preGrade:int;
      
      private var frameArr:Array = [1,16,28,41,53,65,107];
      
      private var addPosArr:Array = [[135,0],[300,0],[375,80],[305,155],[135,155],[60,80]];
      
      private var hasCount:int;
      
      private var needCount:int;
      
      private var isFirst:Boolean = true;
      
      private var _preClickTime:Number;
      
      public function PetContracUpgradeFrame()
      {
         super();
         initView();
         addEvent();
         PlayerManager.instance.currentPlayerModel.setFightingCapacityRecord("start");
      }
      
      override public function get groups() : Array
      {
         return [ComponentGroupType.NONE];
      }
      
      private function initView() : void
      {
         back = ComponentFactory.Instance.creatComponentByStylename("PetContracUpgradeFrame.back");
         addAttImage = ComponentFactory.Instance.creatComponentByStylename("PetContracUpgradeFrame.addAttImage");
         alertText1 = ComponentFactory.Instance.creatComponentByStylename("PetContracUpgradeFrame.alertText1");
         alertText2 = ComponentFactory.Instance.creatComponentByStylename("PetContracUpgradeFrame.alertText2");
         needText = ComponentFactory.Instance.creatComponentByStylename("PetContracUpgradeFrame.needText");
         hasText = ComponentFactory.Instance.creatComponentByStylename("PetContracUpgradeFrame.hasText");
         contracBtn = ComponentFactory.Instance.creatComponentByStylename("PetContracUpgradeFrame.contracBtn");
         petBack = ComponentFactory.Instance.creatComponentByStylename("PetContracUpgradeFrame.petBack");
         petIcon = ComponentFactory.Instance.creatCustomObject("PetContracUpgradeFrame.petIcon");
         upgradeMc = ComponentFactory.Instance.creatCustomObject("PetContracUpgradeFrame.upgradeMc");
         propAddContiner = ComponentFactory.Instance.creatComponentByStylename("PetContracUpgradeFrame.propAddContiner");
         addArrow = ComponentFactory.Instance.creatBitmap("asset.PetContracUpgradeFrame.addArrow");
         addPropText = ComponentFactory.Instance.creatComponentByStylename("PetContracUpgradeFrame.addPropText");
         addValueText = ComponentFactory.Instance.creatComponentByStylename("PetContracUpgradeFrame.addValueText");
         propAddContiner.addChild(addArrow);
         propAddContiner.addChild(addPropText);
         propAddContiner.addChild(addValueText);
         petIcon.mask = createSprite();
         petIcon.buttonMode = true;
         petIcon.mouseEnabled = false;
         addToContent(back);
         addToContent(addAttImage);
         addToContent(petBack);
         addToContent(petIcon);
         addToContent(upgradeMc);
         addToContent(alertText1);
         addToContent(alertText2);
         addToContent(needText);
         addToContent(hasText);
         addToContent(contracBtn);
         addToContent(propAddContiner);
         _filter = new UIFilter();
         alertText1.text = LanguageMgr.GetTranslation("PetContracUpgradeFrame.alertText1.text");
         upgradeMc.mouseChildren = upgradeMc.mouseEnabled = false;
         upgradeMc.gotoAndStop(frameArr[0]);
      }
      
      private function createSprite() : Sprite
      {
         petSprite = new Sprite();
         petSprite.graphics.beginFill(16777215,1);
         petSprite.graphics.drawCircle(280,120,30);
         petSprite.graphics.endFill();
         addToContent(petSprite);
         return petSprite;
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__frameResponse);
         contracBtn.addEventListener("click",__onContracBtnClickHandler);
         MsgMan.addObserver("PET_HALLOWS_MSG_UPDATE",this,__updateMsgHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         contracBtn.removeEventListener("click",__onContracBtnClickHandler);
         MsgMan.removeObserver("PET_HALLOWS_MSG_UPDATE",this,__updateMsgHandler);
      }
      
      private function __updateMsgHandler(param1:String, param2:Object) : void
      {
         refreshView();
      }
      
      private function __onContracBtnClickHandler(param1:MouseEvent) : void
      {
         var _loc2_:Number = getTimer();
         if(_loc2_ - _preClickTime < 1000)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("activity.view.ActivityItem.command01"));
            return;
         }
         _preClickTime = _loc2_;
         if(!model.contracInfoDic[data.PetSonType] || !model.checkIsCanContrac(data))
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("PetContracUpgradeFrame.onContrac.notCanContrac.alert"));
            return;
         }
         if(hasCount < needCount)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("PetContracUpgradeFrame.onContrac.noCount.alert"));
            return;
         }
         contracBtn.enable = false;
         PetHallowsManager.instance.sendPetHallowsRequest(1,data.PetSonType);
      }
      
      public function get data() : PetContracTemplateInfo
      {
         return _data;
      }
      
      public function set data(param1:PetContracTemplateInfo) : void
      {
         _data = param1;
         if(!_data)
         {
            return;
         }
         refreshView();
      }
      
      private function refreshView() : void
      {
         var tempKey:String;
         var addTipData:Object;
         var petTemp:PetTemplate = TempleteManager.instance.petTemplateCate.getPetTemplatesBySonType(data.PetSonType)[0];
         if(petTemp)
         {
            petIcon.icon = IconFactory.getPetHeadSmallIcon(petTemp.TemplateId);
            alertText2.text = LanguageMgr.GetTranslation("PetContracUpgradeFrame.alertText2.text",petTemp.TemplateName);
         }
         if(model.contracInfoDic[data.PetSonType])
         {
            _filter.setNormalFilter(petIcon);
            curTempId = model.contracInfoDic[data.PetSonType];
            alertText2.text = "";
         }
         else
         {
            _filter.setGrayFilter(petIcon);
            curTempId = 0;
            upgradeMc.gotoAndStop(frameArr[0]);
         }
         contracBtn.enable = false;
         curTempInfo = TempleteManager.instance.petContracTemplateCate.getTemplateById(curTempId);
         if(curTempInfo)
         {
            nextTempInfo = model.getContracTempInfoByPetSonTypeAndGrade(curTempInfo.PetSonType,curTempInfo.Grades + 1);
            if(curTempInfo.Grades > preGrade && !isFirst)
            {
               upgradeMc.gotoAndPlay(frameArr[preGrade]);
               closeButton.enable = false;
               upgradeMc.addFrameScript(frameArr[curTempInfo.Grades] - 1,function():void
               {
                  upgradeMc.stop();
                  resetBtnEnable();
                  closeButton.enable = true;
                  if(!nextTempInfo)
                  {
                     dispose();
                     MsgMan.notifyObserver("PET_HALLOWS_MAINMC_UPDATE",curTempInfo);
                  }
               });
            }
            else
            {
               upgradeMc.gotoAndStop(frameArr[curTempInfo.Grades]);
               resetBtnEnable();
            }
            preGrade = curTempInfo.Grades;
         }
         isFirst = false;
         hasCount = GoodsManager.instance.getBagCountInPlayerAndStoneByTempId(208062);
         hasText.text = hasCount + "";
         if(nextTempInfo)
         {
            needCount = nextTempInfo.NeedItemCount;
            needText.text = needCount + "";
            propAddContiner.visible = true;
            tempKey = nextTempInfo.PropertyType + "";
            if(int(nextTempInfo.PropertyType) == 0 && (thane.job == 3 || thane.job == 6))
            {
               tempKey = "1";
            }
            addPropText.text = LanguageMgr.GetTranslation("PetContracAddTips.addPropText" + tempKey);
            addValueText.text = nextTempInfo.PropertyData + "";
            addArrow.x = addPropText.textWidth + 5;
            addValueText.x = addArrow.x + 25;
            propAddContiner.x = addPosArr[curTempInfo.Grades][0];
            propAddContiner.y = addPosArr[curTempInfo.Grades][1];
         }
         else
         {
            needText.text = "0";
            propAddContiner.visible = false;
         }
         if(curTempId != 0)
         {
            addTipData = {};
            addTipData.type = 2;
            addTipData.dic = model.getContracAddDicByTempId(curTempId);
            addAttImage.tipData = addTipData;
         }
         alertText1.visible = !model.checkIsCanContrac(data);
      }
      
      private function resetBtnEnable() : void
      {
         if(model.contracInfoDic[data.PetSonType] && model.checkIsCanContrac(data) && nextTempInfo)
         {
            contracBtn.enable = true;
         }
         else
         {
            contracBtn.enable = false;
         }
      }
      
      private function getPetTypeLanguage(param1:PetTemplate) : String
      {
         var _loc3_:String = LanguageMgr.GetTranslation("pet.petTypeList");
         var _loc2_:Array = _loc3_.split("|");
         var _loc4_:int = param1.PetType - 100;
         if(_loc4_ < 7)
         {
            return _loc2_[_loc4_ - 1];
         }
         return _loc2_[_loc4_ - 11];
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
      
      public function show() : void
      {
         this.titleText = LanguageMgr.GetTranslation("PetContracUpgradeFrame.title.text");
         LayerManager.Instance.addToLayer(this,3,true,true,1);
      }
      
      private function get thane() : ThaneInfo
      {
         return ArmyManager.instance.thane;
      }
      
      private function get model() : PetHallowsModel
      {
         return PetHallowsManager.instance.model;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         _filter = null;
         _data = null;
         frameArr = null;
         addPosArr = null;
         ObjectUtils.disposeObject(back);
         back = null;
         ObjectUtils.disposeObject(addAttImage);
         addAttImage = null;
         ObjectUtils.disposeObject(petBack);
         petBack = null;
         ObjectUtils.disposeObject(petIcon);
         petIcon = null;
         ObjectUtils.disposeViolentMc(upgradeMc);
         upgradeMc = null;
         ObjectUtils.disposeObject(alertText1);
         alertText1 = null;
         ObjectUtils.disposeObject(alertText2);
         alertText2 = null;
         ObjectUtils.disposeObject(needText);
         needText = null;
         ObjectUtils.disposeObject(hasText);
         hasText = null;
         ObjectUtils.disposeObject(contracBtn);
         contracBtn = null;
         ObjectUtils.disposeObject(propAddContiner);
         propAddContiner = null;
         ObjectUtils.disposeObject(addArrow);
         addArrow = null;
         ObjectUtils.disposeObject(addPropText);
         addPropText = null;
         ObjectUtils.disposeObject(addValueText);
         addValueText = null;
         ObjectUtils.disposeObject(petSprite);
         petSprite = null;
         PlayerManager.instance.currentPlayerModel.setFightingCapacityRecord("end");
         super.dispose();
      }
   }
}

