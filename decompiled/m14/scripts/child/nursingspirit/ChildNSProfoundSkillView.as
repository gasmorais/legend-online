package child.nursingspirit
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.utils.ObjectUtils;
   import managers.ChildManager;
   import mvc.module.children.ChildNursingSpiritModel;
   import utils.LogicUtils;
   import yishi.datas.templates.SkillTempInfo;
   
   public class ChildNSProfoundSkillView extends Component
   {
      
      private var leftBack:MutipleImage;
      
      private var rightBack:MutipleImage;
      
      private var itemContiner:Component;
      
      private var skillList:Vector.<ChildNSSkillItemView>;
      
      private var posArr:Array = [[35,55],[155,55],[95,190],[305,55],[425,55],[365,190]];
      
      private var battleSkillView:ChildNsBattleSkillView;
      
      public function ChildNSProfoundSkillView()
      {
         super();
         initView();
         initSkillListView();
      }
      
      private function initView() : void
      {
         leftBack = ComponentFactory.Instance.creatComponentByStylename("ChildNSProfoundSkillView.leftBack");
         rightBack = ComponentFactory.Instance.creatComponentByStylename("ChildNSProfoundSkillView.leftBack");
         itemContiner = ComponentFactory.Instance.creatComponentByStylename("ChildNSProfoundSkillView.itemContiner");
         battleSkillView = ComponentFactory.Instance.creatCustomObject("ChildNSActiveSkillView.battleSkillView");
         addChild(leftBack);
         addChild(rightBack);
         rightBack.x = 280;
         addChild(itemContiner);
         addChild(battleSkillView);
         this.mouseEnabled = false;
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
            _loc3_ = ComponentFactory.Instance.creatCustomObject("ChildNSProfoundSkillView.skillItem",[_loc2_]);
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
         return 5;
      }
      
      private function getSkillTempByI(param1:int) : SkillTempInfo
      {
         var _loc2_:Array = null;
         if(param1 % 3 == 1)
         {
            _loc2_ = nsModel.getNsSkillShowList(nsModel.selectedNsChild.nursingSpiritInfo.jobTypeA,3);
            return _loc2_[int(param1 / 3)];
         }
         if(param1 % 3 == 2)
         {
            _loc2_ = nsModel.getNsSkillShowList(nsModel.selectedNsChild.nursingSpiritInfo.jobTypeB,3);
            return _loc2_[int(param1 / 3)];
         }
         _loc2_ = nsModel.getNsSkillShowList(nsModel.selectedNsChild.job,3);
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
         ObjectUtils.disposeObject(leftBack);
         leftBack = null;
         ObjectUtils.disposeObject(rightBack);
         rightBack = null;
         ObjectUtils.disposeObject(itemContiner);
         itemContiner = null;
         ObjectUtils.disposeObject(battleSkillView);
         battleSkillView = null;
         LogicUtils.disposeDisplayCollection(skillList);
         skillList = null;
         super.dispose();
      }
   }
}

