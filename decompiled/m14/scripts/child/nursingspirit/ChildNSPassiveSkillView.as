package child.nursingspirit
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import manager.LanguageMgr;
   import managers.ChildManager;
   import mvc.module.children.ChildNursingSpiritModel;
   import utils.LogicUtils;
   import yishi.datas.templates.SkillTempInfo;
   
   public class ChildNSPassiveSkillView extends Component
   {
      
      private var backArrow:MutipleImage;
      
      private var alertText:FilterFrameText;
      
      private var itemContiner:Component;
      
      private var skillList:Vector.<ChildNSSkillItemView>;
      
      private var posArr:Array = [[70,50],[180,50],[355,50],[70,140],[180,140],[355,140]];
      
      private var commonSkillView:ChildNSCommonSkillView;
      
      public function ChildNSPassiveSkillView()
      {
         super();
         initView();
         initSkillListView();
      }
      
      private function initView() : void
      {
         backArrow = ComponentFactory.Instance.creatComponentByStylename("ChildNSPassiveSkillView.backArrow");
         alertText = ComponentFactory.Instance.creatComponentByStylename("ChildNSPassiveSkillView.alertText");
         itemContiner = ComponentFactory.Instance.creatComponentByStylename("ChildNSPassiveSkillView.itemContiner");
         commonSkillView = ComponentFactory.Instance.creatCustomObject("ChildNSPassiveSkillView.commonSkillView");
         addChild(backArrow);
         addChild(alertText);
         addChild(itemContiner);
         addChild(commonSkillView);
         this.mouseEnabled = false;
         alertText.text = LanguageMgr.GetTranslation("ChildNSPassiveSkillView.alertText.text");
      }
      
      private function initSkillListView() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:ChildNSSkillItemView = null;
         skillList = new Vector.<ChildNSSkillItemView>();
         _loc1_ = 0;
         while(_loc1_ < 6)
         {
            _loc2_ = getShowTypeByI(_loc1_ + 1);
            _loc3_ = ComponentFactory.Instance.creatCustomObject("ChildNSPassiveSkillView.skillItem",[_loc2_]);
            _loc3_.x = posArr[_loc1_][0];
            _loc3_.y = posArr[_loc1_][1];
            _loc3_.data = getSkillTempByI(_loc1_ + 1);
            itemContiner.addChild(_loc3_);
            skillList.push(_loc3_);
            _loc1_++;
         }
      }
      
      private function getShowTypeByI(param1:int) : int
      {
         if(param1 % 3 == 1)
         {
            return 1;
         }
         if(param1 % 3 == 2)
         {
            return 2;
         }
         return 4;
      }
      
      private function getSkillTempByI(param1:int) : SkillTempInfo
      {
         var _loc2_:Array = null;
         if(param1 % 3 == 1)
         {
            _loc2_ = nsModel.getNsSkillShowList(nsModel.selectedNsChild.nursingSpiritInfo.jobTypeA,2);
            return _loc2_[int(param1 / 3)];
         }
         if(param1 % 3 == 2)
         {
            _loc2_ = nsModel.getNsSkillShowList(nsModel.selectedNsChild.nursingSpiritInfo.jobTypeB,2);
            return _loc2_[int(param1 / 3)];
         }
         _loc2_ = nsModel.getNsSkillShowList(nsModel.selectedNsChild.job,2);
         return _loc2_[int(param1 / 3) - 1];
      }
      
      public function refreshView() : void
      {
         var _loc1_:int = 0;
         commonSkillView.refreshView();
         _loc1_ = 0;
         while(_loc1_ < skillList.length)
         {
            skillList[_loc1_].data = getSkillTempByI(_loc1_ + 1);
            _loc1_++;
         }
      }
      
      private function get nsModel() : ChildNursingSpiritModel
      {
         return ChildManager.instance.nsModel;
      }
      
      override public function dispose() : void
      {
         ObjectUtils.disposeObject(backArrow);
         backArrow = null;
         ObjectUtils.disposeObject(alertText);
         alertText = null;
         ObjectUtils.disposeObject(itemContiner);
         itemContiner = null;
         ObjectUtils.disposeObject(commonSkillView);
         commonSkillView = null;
         LogicUtils.disposeDisplayCollection(skillList);
         skillList = null;
         super.dispose();
      }
   }
}

