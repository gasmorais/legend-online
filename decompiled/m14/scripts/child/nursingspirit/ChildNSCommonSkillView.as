package child.nursingspirit
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import manager.LanguageMgr;
   import managers.ChildManager;
   import mvc.module.children.ChildNursingSpiritModel;
   import utils.LogicUtils;
   
   public class ChildNSCommonSkillView extends Component
   {
      
      private var commonImage:Bitmap;
      
      private var alertText:FilterFrameText;
      
      private var skillList:Vector.<ChildNSSkillItemView>;
      
      private var commonHbox:HBox;
      
      public function ChildNSCommonSkillView()
      {
         super();
         initView();
         initListView();
      }
      
      private function initView() : void
      {
         commonImage = ComponentFactory.Instance.creatBitmap("asset.ChildNSCommonSkillView.commonImage");
         alertText = ComponentFactory.Instance.creatComponentByStylename("ChildNSCommonSkillView.alertText");
         commonHbox = ComponentFactory.Instance.creatComponentByStylename("ChildNSCommonSkillView.commonHbox");
         addChild(commonImage);
         addChild(alertText);
         addChild(commonHbox);
         alertText.text = LanguageMgr.GetTranslation("ChildNSCommonSkillView.alertText.text");
      }
      
      private function initListView() : void
      {
         var _loc1_:int = 0;
         var _loc2_:ChildNSSkillItemView = null;
         skillList = new Vector.<ChildNSSkillItemView>();
         _loc1_ = 0;
         while(_loc1_ < 4)
         {
            _loc2_ = ComponentFactory.Instance.creatCustomObject("ChildNSCommonSkillView.skillItem",[3]);
            _loc2_.data = showList[_loc1_];
            commonHbox.addChild(_loc2_);
            skillList.push(_loc2_);
            _loc1_++;
         }
      }
      
      public function refreshView() : void
      {
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < skillList.length)
         {
            skillList[_loc1_].data = showList[_loc1_];
            _loc1_++;
         }
      }
      
      private function get showList() : Array
      {
         return nsModel.getNsSkillShowList(nsModel.selectedNsChild.job,4);
      }
      
      private function get nsModel() : ChildNursingSpiritModel
      {
         return ChildManager.instance.nsModel;
      }
      
      override public function dispose() : void
      {
         ObjectUtils.disposeObject(commonImage);
         commonImage = null;
         ObjectUtils.disposeObject(alertText);
         alertText = null;
         ObjectUtils.disposeObject(commonHbox);
         commonHbox = null;
         LogicUtils.disposeDisplayCollection(skillList);
         skillList = null;
         super.dispose();
      }
   }
}

