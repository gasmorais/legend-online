package pethallows
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import mvc.module.pet.pethallows.PetHallowsInfo;
   import mvc.module.pet.pethallows.PetHallowsModel;
   import yishi.datas.templates.PetHallowsTemplateInfo;
   import yishi.datas.templates.UpgradeTemplateInfo;
   import yishi.manager.PetHallowsManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.MsgMan;
   import yishi.view.tips.MessageTipManager;
   
   public class PetInscriptionItemView extends Component
   {
      
      private var lightImage:Bitmap;
      
      private var propImage:Bitmap;
      
      private var gradeText:FilterFrameText;
      
      private var expEffect:MovieClip;
      
      private var index:int;
      
      private var _isLock:Boolean;
      
      private var _data:PetHallowsInfo;
      
      private var curTempInfo:PetHallowsTemplateInfo;
      
      private var preExp:int;
      
      private var preShowType:int;
      
      private var isFirst:Boolean = true;
      
      private var propAddText:String;
      
      private var expText:String;
      
      private var titleText:String;
      
      public function PetInscriptionItemView(param1:int)
      {
         super();
         preShowType = model.selectedHallowsTemp.HallowType;
         index = param1;
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         lightImage = ComponentFactory.Instance.creatBitmap("asset.PetInscriptionItemView.lightImage");
         propImage = ComponentFactory.Instance.creatBitmap("asset.PetInscriptionItemView.propImage" + index);
         gradeText = ComponentFactory.Instance.creatComponentByStylename("PetInscriptionItemView.gradeText");
         expEffect = ComponentFactory.Instance.creatCustomObject("PetInscriptionItemView.ExpEffect");
         addChild(lightImage);
         addChild(propImage);
         addChild(gradeText);
         this.buttonMode = true;
         lightImage.visible = false;
         expEffect.gotoAndStop(1);
         expEffect.mouseEnabled = false;
         createSprite();
      }
      
      private function createSprite() : void
      {
         this.graphics.beginFill(16777215,0);
         this.graphics.drawRect(-10,-10,60,60);
         this.graphics.endFill();
      }
      
      private function addEvent() : void
      {
         this.addEventListener("click",__onLockClickHandler);
         this.addEventListener("mouseOver",__onMouseOverHandler);
         this.addEventListener("mouseOut",__onMouseOutHandler);
      }
      
      private function removeEvent() : void
      {
         this.removeEventListener("click",__onLockClickHandler);
         this.removeEventListener("mouseOver",__onMouseOverHandler);
         this.removeEventListener("mouseOut",__onMouseOutHandler);
      }
      
      private function __onLockClickHandler(param1:MouseEvent) : void
      {
         if(!isLock && model.hasLockCount >= 5)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("PetInscriptionView.lock.overAlert"));
            return;
         }
         isLock = !isLock;
      }
      
      public function get isLock() : Boolean
      {
         return _isLock;
      }
      
      public function set isLock(param1:Boolean) : void
      {
         _isLock = param1;
         propImage.visible = !isLock;
         isLock ? gradeText.setFrame(2) : gradeText.setFrame(1);
         updateTips();
         MsgMan.notifyObserver("PET_INSCRIPTION_LOCK_CHANGE");
      }
      
      private function __onMouseOverHandler(param1:MouseEvent) : void
      {
         lightImage.visible = true;
      }
      
      private function __onMouseOutHandler(param1:MouseEvent) : void
      {
         lightImage.visible = false;
      }
      
      public function set data(param1:PetHallowsInfo) : void
      {
         _data = param1;
         refreshView();
      }
      
      private function refreshView() : void
      {
         var _loc5_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:UpgradeTemplateInfo = null;
         var _loc2_:UpgradeTemplateInfo = null;
         var _loc1_:int = 0;
         if(!_data)
         {
            curTempInfo = model.getHallowsTempInfoByTypeAndGrade(model.selectedHallowsTemp.HallowType,1);
            expText = LanguageMgr.GetTranslation("PetInscriptionItemView.tipData.expText",0,0);
            propAddText = LanguageMgr.GetTranslation("PetContracAddTips.addPropText" + model.getLanguageType(index,curTempInfo)) + " + 0";
         }
         else
         {
            _loc1_ = int(_data["propAddGrade" + index]);
            _loc3_ = _data["propAddGp" + index] - preExp;
            if(!isFirst && preShowType == model.selectedHallowsTemp.HallowType && _data["propAddGp" + index] > preExp)
            {
               expEffect.gotoAndPlay(1);
               expEffect["expTxt"]["text"].text = LanguageMgr.GetTranslation("mopup.view.MazeMopupIngFrame.gainExpTxt") + "+" + _loc3_;
               expEffect["expTxt"]["text"].setTextFormat(ComponentFactory.Instance.model.getSet("PetInscriptionItemView.addExp.textFormat"));
               addChild(expEffect);
            }
            preExp = _data["propAddGp" + index];
            preShowType = model.selectedHallowsTemp.HallowType;
            curTempInfo = _data.templateInfo;
            _loc5_ = int(model.getLeftExpByTotalExp(_data["propAddGp" + index]));
            _loc4_ = TempleteManager.instance.getTemplateByLevelAndType(_loc1_,127);
            _loc2_ = TempleteManager.instance.getTemplateByLevelAndType(_loc1_ + 1,127);
            if(_loc4_)
            {
               propAddText = LanguageMgr.GetTranslation("PetContracAddTips.addPropText" + model.getLanguageType(index,curTempInfo)) + " + " + _loc4_.ActiveObject + "%";
            }
            else
            {
               propAddText = LanguageMgr.GetTranslation("PetContracAddTips.addPropText" + model.getLanguageType(index,curTempInfo)) + " + " + 0;
            }
            if(_loc2_)
            {
               expText = LanguageMgr.GetTranslation("PetInscriptionItemView.tipData.expText",_loc5_,_loc2_.Data);
            }
            else
            {
               expText = LanguageMgr.GetTranslation("yishi.view.tips.goods.StarTip.gp01");
            }
         }
         isFirst = false;
         gradeText.text = LanguageMgr.GetTranslation("public.level2",_loc1_);
         titleText = LanguageMgr.GetTranslation("PetInscriptionItemView.tipData.title" + index) + " " + LanguageMgr.GetTranslation("public.level2",_loc1_);
         updateTips();
      }
      
      private function updateTips() : void
      {
         this.tipData = getTipsStr(titleText,expText,propAddText);
      }
      
      private function getTipsStr(param1:String, param2:String, param3:String) : String
      {
         var _loc5_:String = null;
         var _loc6_:String = LanguageMgr.GetTranslation("PetInscriptionItemView.tipData.notOpenText");
         var _loc4_:String = LanguageMgr.GetTranslation("PetInscriptionItemView.tipData.canCloseText");
         _loc5_ = "<font color=\'#5ccae9\'>" + param1 + "\n" + "</font>" + "<font color=\'#ffe400\'>" + param2 + "\n" + "</font>" + "<font color=\'#ffe400\'>" + param3 + "</font>";
         if(isLock)
         {
            _loc5_ += "\n<font color=\'#ff4504\'>" + _loc6_ + "</font>";
         }
         else
         {
            _loc5_ += "\n<font color=\'#ff4504\'>" + _loc4_ + "</font>";
         }
         return _loc5_;
      }
      
      private function get model() : PetHallowsModel
      {
         return PetHallowsManager.instance.model;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(lightImage);
         lightImage = null;
         ObjectUtils.disposeObject(propImage);
         propImage = null;
         ObjectUtils.disposeObject(gradeText);
         gradeText = null;
         ObjectUtils.disposeViolentMc(expEffect);
         expEffect = null;
         super.dispose();
      }
   }
}

