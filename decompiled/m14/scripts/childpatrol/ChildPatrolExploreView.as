package childpatrol
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import events.ChildPatrolEvent;
   import flash.display.Bitmap;
   import manager.LanguageMgr;
   import managers.ChildManager;
   import managers.ChildPatrolManager;
   import mvc.module.childpatrol.ChildPatrolTowerInfo;
   import mvc.module.children.ChildData;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.templates.ChildTempInfo;
   import yishi.datas.templates.GuardPveExploreRewardInfo;
   import yishi.manager.TempleteManager;
   import yishi.view.community.BaseItemView;
   
   public class ChildPatrolExploreView extends Component
   {
      
      private var back:MutipleImage;
      
      private var descriptText:FilterFrameText;
      
      private var stateText:FilterFrameText;
      
      private var _hardbackBox:HBox;
      
      private var _hardRewardBox:HBox;
      
      private var _rewardList:Array;
      
      private var _data:ChildPatrolTowerInfo;
      
      public function ChildPatrolExploreView()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         back = ComponentFactory.Instance.creatComponentByStylename("ChildPatrolExplore.back");
         descriptText = ComponentFactory.Instance.creatComponentByStylename("ChildPatrolExplore.descriptTxt");
         stateText = ComponentFactory.Instance.creatComponentByStylename("ChildPatrolExplore.stateTxt");
         _hardbackBox = ComponentFactory.Instance.creatCustomObject("childpve.explore.advanceRewardBackBox");
         _hardRewardBox = ComponentFactory.Instance.creatCustomObject("childpve.explore.advanceRewardBox");
         addChild(back);
         addChild(descriptText);
         addChild(stateText);
         addChild(_hardbackBox);
         addChild(_hardRewardBox);
         descriptText.htmlText = LanguageMgr.GetTranslation("ChildPatrolExplore.descriptTip");
         initBackBox(_hardbackBox);
      }
      
      private function initEvent() : void
      {
         ChildPatrolManager.instance.addEventListener("SELECT_ADD_CHILDPATROL",__addChildToListHandler);
         ChildPatrolManager.instance.addEventListener("SELECT_DEL_CHILDPATROL",__delChildToListHandler);
      }
      
      private function removeEvent() : void
      {
         ChildPatrolManager.instance.removeEventListener("SELECT_ADD_CHILDPATROL",__addChildToListHandler);
         ChildPatrolManager.instance.removeEventListener("SELECT_DEL_CHILDPATROL",__delChildToListHandler);
      }
      
      private function __addChildToListHandler(param1:ChildPatrolEvent) : void
      {
         var _loc2_:ChildData = param1.data as ChildData;
         refreshRewards(_loc2_);
      }
      
      private function __delChildToListHandler(param1:ChildPatrolEvent) : void
      {
         var _loc2_:ChildData = param1.data as ChildData;
         _hardRewardBox.removeAllChild();
      }
      
      public function set data(param1:ChildPatrolTowerInfo) : void
      {
         var _loc2_:ChildData = null;
         _data = param1;
         if(_data)
         {
            if(_data.bossState == 1)
            {
               stateText.htmlText = LanguageMgr.GetTranslation("ChildPatrolExplore.stateOpen") + LanguageMgr.GetTranslation("ChildPatrolExplore.stateHasDo");
            }
            else
            {
               stateText.htmlText = LanguageMgr.GetTranslation("ChildPatrolExplore.stateOpen") + LanguageMgr.GetTranslation("ChildPatrolExplore.stateNoDo");
            }
            if(_data.exploreChildId > 0)
            {
               _loc2_ = ChildManager.instance.model.getChildById(_data.exploreChildId);
               refreshRewards(_loc2_);
            }
            else
            {
               _hardRewardBox.removeAllChild();
            }
         }
         else
         {
            _hardRewardBox.removeAllChild();
            stateText.htmlText = LanguageMgr.GetTranslation("ChildPatrolExplore.stateOpen") + LanguageMgr.GetTranslation("ChildPatrolExplore.stateNoDo");
         }
      }
      
      private function initBackBox(param1:HBox) : void
      {
         var _loc4_:Bitmap = null;
         var _loc2_:BaseItemView = null;
         var _loc3_:int = 0;
         param1.beginChanges();
         _rewardList = [];
         _loc3_ = 0;
         while(_loc3_ < 5)
         {
            _loc4_ = ComponentFactory.Instance.creatBitmap("asset.ChildPatrol.explore.rewardBack");
            param1.addChild(_loc4_);
            _loc2_ = ComponentFactory.Instance.creatCustomObject("ChildPatrolTaskView.baseItem");
            _rewardList[_loc3_] = _loc2_;
            _loc3_++;
         }
         param1.commitChanges();
      }
      
      private function refreshRewards(param1:ChildData) : void
      {
         var _loc5_:Array = null;
         var _loc3_:int = 0;
         var _loc4_:GuardPveExploreRewardInfo = null;
         var _loc2_:BaseItemView = null;
         var _loc7_:GoodsInfo = null;
         var _loc6_:int = 0;
         _hardRewardBox.removeAllChild();
         if(param1 == null)
         {
            return;
         }
         var _loc8_:ChildTempInfo = TempleteManager.instance.childTemplateCate.getTemplateByJobAndGrades(param1.job,param1.growthGrade);
         if(_loc8_ != null)
         {
            _loc5_ = TempleteManager.instance.guardPveExploreTemplateCate.getDropList(_loc8_.MasterType,param1.growthGrade);
            _loc3_ = int(_loc5_ == null ? 0 : _loc5_.length);
            _hardRewardBox.beginChanges();
            while(_loc6_ < _loc3_)
            {
               _loc2_ = ComponentFactory.Instance.creatCustomObject("ChildPatrolTaskView.baseItem");
               _loc4_ = _loc5_[_loc6_];
               _loc7_ = new GoodsInfo();
               _loc7_.templateId = _loc4_.itemId;
               _loc7_.count = _loc4_.count;
               _loc2_.data = _loc7_;
               _hardRewardBox.addChild(_loc2_);
               _loc6_++;
            }
            _hardRewardBox.commitChanges();
         }
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(back);
         back = null;
         ObjectUtils.disposeObject(descriptText);
         descriptText = null;
         ObjectUtils.disposeObject(stateText);
         stateText = null;
         ObjectUtils.disposeObject(_hardRewardBox);
         _hardRewardBox = null;
         ObjectUtils.disposeObject(_hardbackBox);
         _hardbackBox = null;
         for each(var _loc1_:BaseItemView in _rewardList)
         {
            ObjectUtils.disposeObject(_loc1_);
         }
         _rewardList = null;
         super.dispose();
         _data = null;
      }
   }
}

