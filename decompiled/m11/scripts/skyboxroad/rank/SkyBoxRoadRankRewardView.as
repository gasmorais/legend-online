package skyboxroad.rank
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.utils.Dictionary;
   import yishi.manager.TempleteManager;
   
   public class SkyBoxRoadRankRewardView extends Component
   {
      
      private var _bg:Bitmap;
      
      private var _vBox:VBox;
      
      private var _skillPanel:ScrollPanel;
      
      public function SkyBoxRoadRankRewardView()
      {
         super();
         initView();
         initListInfo();
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatBitmap("asset.skysecretarea.rankBg4");
         _skillPanel = ComponentFactory.Instance.creatComponentByStylename("skysecretarea.ScrollPanel");
         _vBox = ComponentFactory.Instance.creatComponentByStylename("skysecretarea.battleSkillVbox");
         addChild(_bg);
         _skillPanel.setView(_vBox);
         _skillPanel.invalidateViewport();
         addChild(_skillPanel);
      }
      
      private function initListInfo() : void
      {
         var _loc3_:SkyBoxRoadRankRewardItem = null;
         var _loc5_:int = 0;
         var _loc6_:Dictionary = TempleteManager.instance.skyBoxRoadRankRewardTempCate.getTemplates();
         var _loc1_:Array = [];
         for(var _loc2_:String in _loc6_)
         {
            _loc1_.push(int(_loc2_));
         }
         _loc1_.sort(sortFun);
         var _loc4_:int = int(_loc1_.length);
         _loc5_ = 0;
         while(_loc5_ < _loc4_)
         {
            _loc3_ = new SkyBoxRoadRankRewardItem();
            _loc3_.data = _loc6_[_loc1_[_loc5_]];
            _vBox.addChild(_loc3_);
            _loc5_ += 1;
         }
         _skillPanel.invalidateViewport();
      }
      
      private function sortFun(param1:int, param2:int) : int
      {
         if(param1 < param2)
         {
            return -1;
         }
         if(param1 == param2)
         {
            return 1;
         }
         return 1;
      }
      
      override public function dispose() : void
      {
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeAllChildren(_vBox);
         ObjectUtils.disposeObject(_vBox);
         _vBox = null;
         ObjectUtils.disposeObject(_skillPanel);
         _skillPanel = null;
         ObjectUtils.disposeAllChildren(this);
         super.dispose();
      }
   }
}

