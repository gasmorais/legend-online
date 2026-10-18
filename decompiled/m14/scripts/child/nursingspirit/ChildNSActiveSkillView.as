package child.nursingspirit
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.utils.ObjectUtils;
   import managers.ChildManager;
   import mvc.module.children.ChildNursingSpiritModel;
   import utils.LogicUtils;
   import yishi.datas.templates.SkillTempInfo;
   
   public class ChildNSActiveSkillView extends Component
   {
      
      private var composeArrowHbox:HBox;
      
      private var oneComposeImage:MutipleImage;
      
      private var itemContiner:Component;
      
      private var skillList:Vector.<ChildNSSkillItemView>;
      
      private var battleSkillView:ChildNsBattleSkillView;
      
      private var posArr:Array = [[15,25],[15,117],[15,225],[100,25],[100,117],[100,225],[185,25],[185,117],[185,225],[270,25],[270,117],[270,225],[355,25],[355,117],[355,225],[440,25],[440,117],[440,225]];
      
      public function ChildNSActiveSkillView()
      {
         super();
         initView();
         initSkillListView();
      }
      
      private function initView() : void
      {
         var _loc1_:int = 0;
         composeArrowHbox = ComponentFactory.Instance.creatComponentByStylename("ChildNSActiveSkillView.composeArrowHbox");
         itemContiner = ComponentFactory.Instance.creatComponentByStylename("ChildNSActiveSkillView.itemContiner");
         battleSkillView = ComponentFactory.Instance.creatCustomObject("ChildNSActiveSkillView.battleSkillView");
         addChild(composeArrowHbox);
         addChild(itemContiner);
         addChild(battleSkillView);
         this.mouseEnabled = false;
         _loc1_ = 0;
         while(_loc1_ < 6)
         {
            oneComposeImage = ComponentFactory.Instance.creatComponentByStylename("ChildNSActiveSkillView.oneComposeImage");
            composeArrowHbox.addChild(oneComposeImage);
            _loc1_++;
         }
      }
      
      private function initSkillListView() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:ChildNSSkillItemView = null;
         skillList = new Vector.<ChildNSSkillItemView>();
         _loc1_ = 0;
         while(_loc1_ < 18)
         {
            _loc2_ = getShowTypeByI(_loc1_ + 1);
            _loc3_ = ComponentFactory.Instance.creatCustomObject("ChildNSActiveSkillView.skillItem",[_loc2_]);
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
            _loc2_ = nsModel.getNsSkillShowList(nsModel.selectedNsChild.nursingSpiritInfo.jobTypeA,1);
            return _loc2_[int(param1 / 3)];
         }
         if(param1 % 3 == 2)
         {
            _loc2_ = nsModel.getNsSkillShowList(nsModel.selectedNsChild.nursingSpiritInfo.jobTypeB,1);
            return _loc2_[int(param1 / 3)];
         }
         _loc2_ = nsModel.getNsSkillShowList(nsModel.selectedNsChild.job,1);
         return _loc2_[int(param1 / 3) - 1];
      }
      
      public function refreshView() : void
      {
         var _loc1_:int = 0;
         battleSkillView.refreshView();
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
         ObjectUtils.disposeObject(composeArrowHbox);
         composeArrowHbox = null;
         ObjectUtils.disposeObject(oneComposeImage);
         oneComposeImage = null;
         ObjectUtils.disposeObject(battleSkillView);
         battleSkillView = null;
         ObjectUtils.disposeObject(itemContiner);
         itemContiner = null;
         LogicUtils.disposeDisplayCollection(skillList);
         skillList = null;
         super.dispose();
      }
   }
}

