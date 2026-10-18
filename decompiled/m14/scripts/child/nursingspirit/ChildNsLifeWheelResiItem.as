package child.nursingspirit
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import managers.ChildManager;
   import mvc.module.children.ChildNursingSpiritModel;
   import mvc.module.children.NsLifeWheelInfo;
   import yishi.datas.templates.UpgradeTemplateInfo;
   import yishi.manager.TempleteManager;
   
   public class ChildNsLifeWheelResiItem extends Component
   {
      
      private var resiIcon:ScaleFrameImage;
      
      private var levelTxt:FilterFrameText;
      
      private var level:int;
      
      private var index:int;
      
      private var curTemp:UpgradeTemplateInfo;
      
      private var nextTemp:UpgradeTemplateInfo;
      
      private var lifeWheelInfo:NsLifeWheelInfo;
      
      public function ChildNsLifeWheelResiItem(param1:int)
      {
         super();
         index = param1;
         initView();
         addEvent();
         refreshView();
      }
      
      private function initView() : void
      {
         resiIcon = ComponentFactory.Instance.creatComponentByStylename("ChildNSTalentItemView.TalentIcon" + index);
         levelTxt = ComponentFactory.Instance.creatComponentByStylename("ChildNsLifeWheelResiItem.levelTxt");
         addChild(resiIcon);
         addChild(levelTxt);
      }
      
      private function addEvent() : void
      {
         resiIcon.addEventListener("mouseOver",__overHandler);
         resiIcon.addEventListener("mouseOut",__outHandler);
      }
      
      private function removeEvent() : void
      {
         if(resiIcon)
         {
            resiIcon.removeEventListener("mouseOver",__overHandler);
         }
         if(resiIcon)
         {
            resiIcon.removeEventListener("mouseOut",__outHandler);
         }
      }
      
      private function __overHandler(param1:MouseEvent) : void
      {
         resiIcon.setFrame(2);
      }
      
      private function __outHandler(param1:MouseEvent) : void
      {
         resiIcon.setFrame(1);
      }
      
      public function refreshView() : void
      {
         lifeWheelInfo = nsModel.selectedNsChild.nursingSpiritInfo.lifeWheelInfo;
         level = lifeWheelInfo.resiGradeArr[index];
         curTemp = TempleteManager.instance.getTemplateByLevelAndType(level,133);
         nextTemp = TempleteManager.instance.getTemplateByLevelAndType(level + 1,133);
         levelTxt.text = LanguageMgr.GetTranslation("public.level2",level);
         updateTips();
      }
      
      private function updateTips() : void
      {
         var _loc6_:String = null;
         var _loc2_:String = null;
         var _loc1_:String = null;
         var _loc5_:int = index + 1;
         var _loc4_:String = LanguageMgr.GetTranslation("planesRewardTip.resistance.typeText" + _loc5_);
         var _loc3_:String = LanguageMgr.GetTranslation("ChildNsLifeWheelResiItem.tipdata.titleText",_loc4_,LanguageMgr.GetTranslation("public.level2",level));
         if(nextTemp)
         {
            _loc2_ = LanguageMgr.GetTranslation("ChildNsLifeWheelResiItem.tipdata.expText1",lifeWheelInfo.resiGpArr[index],nextTemp.Data);
         }
         else
         {
            _loc2_ = LanguageMgr.GetTranslation("ChildNsLifeWheelResiItem.tipdata.expText2");
         }
         _loc1_ = LanguageMgr.GetTranslation("ChildNsLifeWheelResiItem.tipdata.valueText",_loc4_,curTemp.ActiveObject);
         _loc6_ = "<font color=\'#5ccae9\'>" + _loc3_ + "\n" + "</font>" + "<font color=\'#ffe400\'>" + _loc2_ + "\n" + "</font>" + "<font color=\'#ffe400\'>" + _loc1_ + "</font>";
         this.tipData = _loc6_;
      }
      
      private function get nsModel() : ChildNursingSpiritModel
      {
         return ChildManager.instance.nsModel;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(resiIcon);
         resiIcon = null;
         ObjectUtils.disposeObject(levelTxt);
         levelTxt = null;
         super.dispose();
      }
   }
}

