package guidetask
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import managers.GuideTaskManager;
   import mvc.module.guidetask.GuideTaskUpgradeInfo;
   import yishi.manager.FrameControllerManager;
   
   public class GuideLevelView extends Sprite implements Disposeable
   {
      
      private var _titleback:MutipleImage;
      
      private var _titleImg:Bitmap;
      
      private var _box:VBox;
      
      private var _purposeBtn:IconButton;
      
      private var _tabButtonGruoup:SelectedButtonGroup;
      
      public function GuideLevelView()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         var _loc2_:int = 0;
         var _loc1_:GuideLevelItem = null;
         _tabButtonGruoup = new SelectedButtonGroup();
         _titleback = ComponentFactory.Instance.creatComponentByStylename("guidetask.leveltitleBGImage");
         _titleImg = ComponentFactory.Instance.creatBitmap("asset.guidetask.upgradeLevelImg");
         _box = ComponentFactory.Instance.creatComponentByStylename("guidetask.levelVBox");
         _purposeBtn = ComponentFactory.Instance.creatComponentByStylename("guidetask.purposeBtn");
         addChild(_titleback);
         addChild(_titleImg);
         _loc2_ = 0;
         while(_loc2_ < 5)
         {
            _loc1_ = new GuideLevelItem();
            _box.addChild(_loc1_);
            _tabButtonGruoup.addSelectItem(_loc1_);
            _loc2_++;
         }
         addChild(_box);
         addChild(_purposeBtn);
      }
      
      public function refreshData() : void
      {
         var _loc2_:GuideLevelItem = null;
         var _loc5_:int = 0;
         var _loc4_:GuideTaskUpgradeInfo = null;
         var _loc1_:Array = GuideTaskManager.instance.getSomethingCanToDo();
         var _loc3_:int = int(_loc1_.length);
         _loc5_ = 0;
         while(_loc5_ < _loc3_)
         {
            _loc4_ = _loc1_[_loc5_] as GuideTaskUpgradeInfo;
            if(_loc5_ < 2)
            {
               _loc4_.expSort = 1;
            }
            else
            {
               _loc4_.expSort = 0;
            }
            _loc2_ = _box.getChildAt(_loc5_) as GuideLevelItem;
            _loc2_.data = _loc4_;
            _loc5_++;
         }
      }
      
      private function initEvent() : void
      {
         _purposeBtn.addEventListener("click",__purposeBtnHandler);
      }
      
      private function removeEvent() : void
      {
         _purposeBtn.removeEventListener("click",__purposeBtnHandler);
      }
      
      private function __purposeBtnHandler(param1:MouseEvent) : void
      {
         var _loc2_:* = FrameControllerManager.instance.guideTaskController.frame;
         if(_loc2_)
         {
            _loc2_.changePage(1);
         }
      }
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_titleback);
         _titleback = null;
         ObjectUtils.disposeObject(_titleImg);
         _titleImg = null;
         ObjectUtils.disposeObject(_box);
         _box = null;
         ObjectUtils.disposeObject(_purposeBtn);
         _purposeBtn = null;
         _tabButtonGruoup = null;
      }
   }
}

