package steel.view.search
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import manager.LanguageMgr;
   import map.campaign.data.SteelModel;
   import map.campaign.event.SteelEvent;
   import mvc.controler.SteelController;
   import yishi.manager.FrameControllerManager;
   
   public class SteelSearchRightView extends Sprite implements Disposeable
   {
      
      private var _rightBg:ScaleBitmapImage;
      
      private var _rightTitlebarBg:MutipleImage;
      
      private var _rightItemBg1:Bitmap;
      
      private var _chairmanTxt:FilterFrameText;
      
      private var _operationTxt:FilterFrameText;
      
      private var _controller:SteelController;
      
      private var _model:SteelModel;
      
      private var _applyItemList:Array = [];
      
      public function SteelSearchRightView()
      {
         super();
         _controller = FrameControllerManager.instance.steelController;
         _model = _controller.model;
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         var _loc2_:int = 0;
         var _loc1_:Bitmap = null;
         _rightBg = ComponentFactory.Instance.creatComponentByStylename("steel.SteelSearchRightView.Bg");
         _rightTitlebarBg = ComponentFactory.Instance.creatComponentByStylename("steel.SteelSearchRightView.TitleGap");
         _rightItemBg1 = ComponentFactory.Instance.creatBitmap("asset.consortia.itemBg");
         _chairmanTxt = ComponentFactory.Instance.creatComponentByStylename("steel.SteelSearchRightView.TeamNameTxt");
         _operationTxt = ComponentFactory.Instance.creatComponentByStylename("steel.SteelSearchRightView.OperationTxt");
         _chairmanTxt.text = LanguageMgr.GetTranslation("steel.view.search.SteelSearchFrame.TitleTxt01");
         _operationTxt.text = LanguageMgr.GetTranslation("consortia.view.club.ConsortiaSearchRightView.operationTxtText");
         _rightItemBg1.y = 37;
         addChild(_rightBg);
         addChild(_rightTitlebarBg);
         addChild(_chairmanTxt);
         addChild(_operationTxt);
         _loc2_ = 0;
         while(_loc2_ < 10)
         {
            _loc1_ = new Bitmap(_rightItemBg1.bitmapData);
            _loc1_.x = _rightItemBg1.x;
            _loc1_.y = _rightItemBg1.y + _loc2_ * 33;
            addChild(_loc1_);
            _loc2_++;
         }
      }
      
      private function uninitView() : void
      {
         ObjectUtils.disposeAllChildren(this);
         _model = null;
      }
      
      private function addEvent() : void
      {
         _model.addEventListener("STEEL_APPLY_LIST_CHANGE",__applyListChangeHandler);
      }
      
      private function removeEvent() : void
      {
         _model.removeEventListener("STEEL_APPLY_LIST_CHANGE",__applyListChangeHandler);
      }
      
      private function __applyListChangeHandler(param1:SteelEvent) : void
      {
         refreshView();
      }
      
      private function refreshView() : void
      {
         var _loc1_:SteelRecordItem = null;
         var _loc2_:int = 0;
         var _loc3_:Array = _model.applyList;
         for each(_loc1_ in _applyItemList)
         {
            _loc1_.dispose();
         }
         _applyItemList.length = 0;
         _loc2_ = 0;
         while(_loc2_ < _model.applyList.length)
         {
            _loc1_ = new SteelRecordItem();
            _loc1_.x = 475;
            _loc1_.y = 38 + _loc2_ * 33;
            _loc1_.data = _loc3_[_loc2_];
            addChild(_loc1_);
            _applyItemList.push(_loc1_);
            _loc2_++;
         }
      }
      
      public function dispose() : void
      {
         removeEvent();
         uninitView();
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

