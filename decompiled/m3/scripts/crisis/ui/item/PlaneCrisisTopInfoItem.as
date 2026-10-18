package crisis.ui.item
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import yishi.events.NotificationEvent;
   import yishi.manager.NotificationManager;
   import yishi.manager.PlaneCrisisManager;
   import yishi.view.base.ProgressPanel;
   
   public class PlaneCrisisTopInfoItem extends Component
   {
      
      private var _redData:BitmapData;
      
      private var _yellowData:BitmapData;
      
      private var _greenData:BitmapData;
      
      private var _emptyData:BitmapData;
      
      private var _back:MutipleImage;
      
      private var _gridBox:HBox;
      
      private var _gridList:Vector.<Bitmap>;
      
      private var _gridTxt:FilterFrameText;
      
      private var _progress:ProgressPanel;
      
      private var _tagetFlg:Bitmap;
      
      private var MAX_GRID:int = 18;
      
      public function PlaneCrisisTopInfoItem()
      {
         super();
         initView();
         initEvent();
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_redData);
         _redData = null;
         ObjectUtils.disposeObject(_yellowData);
         _yellowData = null;
         ObjectUtils.disposeObject(_greenData);
         _greenData = null;
         ObjectUtils.disposeObject(_emptyData);
         _emptyData = null;
         ObjectUtils.disposeObject(_gridBox);
         _gridBox = null;
         ObjectUtils.disposeObject(_back);
         _back = null;
         ObjectUtils.disposeObject(_gridTxt);
         _gridTxt = null;
         ObjectUtils.disposeObject(_progress);
         _progress = null;
         ObjectUtils.disposeObject(_tagetFlg);
         _tagetFlg = null;
         if(parent)
         {
            parent.removeChild(this);
         }
         _gridList = null;
         super.dispose();
      }
      
      private function initEvent() : void
      {
         NotificationManager.instance.addEventListener("PlaneCrisisLeftView.EVENT_REFRESH_TOP",updateViewHandler);
      }
      
      private function removeEvent() : void
      {
         NotificationManager.instance.removeEventListener("PlaneCrisisLeftView.EVENT_REFRESH_TOP",updateViewHandler);
      }
      
      private function updateViewHandler(param1:NotificationEvent) : void
      {
         var _loc3_:int = 0;
         var _loc7_:int = 0;
         var _loc4_:int = 0;
         var _loc6_:int = 0;
         var _loc5_:int = 0;
         var _loc2_:Array = param1.data as Array;
         if(_loc2_ != null)
         {
            _loc3_ = int(_loc2_[0]);
            refreshActionNum(_loc3_);
            _gridTxt.text = _loc3_ + "/20";
            _loc7_ = int(_loc2_[1]);
            _loc4_ = int(_loc2_[3]);
            _progress.progressValue(_loc7_,_loc4_,true);
            _loc6_ = int(_loc2_[2]);
            _loc5_ = 9 + _loc6_ / _loc4_ * 316;
            _tagetFlg.x = _loc5_;
            _tagetFlg.y = 3;
            if(_loc7_ >= _loc6_)
            {
               _progress.setTextFrameIndex(2);
            }
            else
            {
               _progress.setTextFrameIndex(1);
            }
         }
      }
      
      private function initView() : void
      {
         var _loc2_:Bitmap = null;
         var _loc1_:int = 0;
         MAX_GRID = PlaneCrisisManager.Instance.model.currMapId == 1 ? 18 : 20;
         _redData = ComponentFactory.Instance.creatBitmap("asset.planecrisis.gridRed").bitmapData;
         _yellowData = ComponentFactory.Instance.creatBitmap("asset.planecrisis.gridYellow").bitmapData;
         _greenData = ComponentFactory.Instance.creatBitmap("asset.planecrisis.gridGreen").bitmapData;
         _emptyData = ComponentFactory.Instance.creatBitmap("asset.planecrisis.gridEmpty").bitmapData;
         _tagetFlg = ComponentFactory.Instance.creatBitmap("asset.planecrisis.t.split");
         _back = ComponentFactory.Instance.creatComponentByStylename("xmlui.planecrisis.fla.topItemInfoBack");
         _gridBox = ComponentFactory.Instance.creatCustomObject("planecrisis.TopLeftGridBox");
         _gridTxt = ComponentFactory.Instance.creatComponentByStylename("ui.planecrisis.Topleft.teamargmentTxt");
         _progress = new ProgressPanel();
         _progress.initView("asset.planecrisis.t.grayBar","asset.planecrisis.t.yellowBar","ui.planecrisis.Topleft.progressTxt");
         _progress.barPosxy(9,4);
         _progress.x = 80;
         _progress.y = 34;
         addChild(_back);
         addChild(_gridBox);
         addChild(_gridTxt);
         addChild(_progress);
         _progress.addChild(_tagetFlg);
         _gridList = new Vector.<Bitmap>();
         _gridBox.beginChanges();
         _loc1_ = 0;
         while(_loc1_ < MAX_GRID)
         {
            _loc2_ = new Bitmap();
            _gridList[_loc1_] = _loc2_;
            _gridBox.addChild(_loc2_);
            _loc1_++;
         }
         _gridBox.commitChanges();
      }
      
      private function refreshActionNum(param1:int) : void
      {
         var _loc2_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < MAX_GRID)
         {
            if(_loc2_ < param1)
            {
               if(_loc2_ < 7)
               {
                  _gridList[_loc2_].bitmapData = _redData;
               }
               else if(_loc2_ < 14)
               {
                  _gridList[_loc2_].bitmapData = _yellowData;
               }
               else
               {
                  _gridList[_loc2_].bitmapData = _greenData;
               }
            }
            else
            {
               _gridList[_loc2_].bitmapData = _emptyData;
            }
            _loc2_++;
         }
      }
   }
}

