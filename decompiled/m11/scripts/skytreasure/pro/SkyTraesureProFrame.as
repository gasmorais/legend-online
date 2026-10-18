package skytreasure.pro
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.geom.IntPoint;
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import flash.display.Sprite;
   import flash.geom.Rectangle;
   import manager.LanguageMgr;
   import mvc.module.skytreasure.LotteryRateInfo;
   import mvc.module.skytreasure.SkyTreasureActTemplateInfo;
   import mvc.module.skytreasure.SkyTreasureModelNew;
   import yishi.manager.SkyTreasureManager;
   
   public class SkyTraesureProFrame extends Frame implements IManualSize
   {
      
      private var _border:ScaleBitmapImage;
      
      private var _contentScrollPanel:ScrollPanel;
      
      private var _centerGoodsListView:Sprite;
      
      private var _act:SkyTreasureActTemplateInfo;
      
      public function SkyTraesureProFrame()
      {
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         _contentScrollPanel = ComponentFactory.Instance.creatComponentByStylename("skytreasure.GameHallEastShopDescFrame.contentScrollPanel");
         _centerGoodsListView = new Sprite();
         addToContent(_contentScrollPanel);
         _contentScrollPanel.setView(_centerGoodsListView);
      }
      
      private function uninitView() : void
      {
         ObjectUtils.disposeObject(_border);
         _border = null;
         ObjectUtils.disposeObject(_centerGoodsListView);
         _centerGoodsListView = null;
         ObjectUtils.disposeObject(_contentScrollPanel);
         _contentScrollPanel = null;
         ObjectUtils.disposeAllChildren(this);
         ObjectUtils.disposeSelf(this);
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__frameResponse);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
      }
      
      private function get pumpModel() : SkyTreasureModelNew
      {
         return SkyTreasureManager.Instance.modelNew;
      }
      
      private function sortRateAsc(param1:Object, param2:Object) : int
      {
         var _loc3_:Number = 0;
         var _loc4_:Number = 0;
         if(param1.rate && param1.rate is String)
         {
            _loc3_ = Number(param1.rate.toString().replace("%",""));
         }
         if(param2.rate && param2.rate is String)
         {
            _loc4_ = Number(param2.rate.toString().replace("%",""));
         }
         if(_loc3_ < _loc4_)
         {
            return -1;
         }
         if(_loc3_ > _loc4_)
         {
            return 1;
         }
         return 0;
      }
      
      private function __panelChangeHandler() : void
      {
         var _loc5_:int = 0;
         var _loc2_:SkyTreasureProItem = null;
         var _loc1_:LotteryRateInfo = null;
         var _loc6_:int = 0;
         SoundManager.instance.play("022");
         var _loc3_:Array = _act.lotteryRatePoolInfoArray.sort(sortRateAsc);
         var _loc4_:IntPoint = new IntPoint();
         if(_loc3_)
         {
            _loc5_ = 3;
            if(_centerGoodsListView && _centerGoodsListView.numChildren > 0)
            {
               _centerGoodsListView.removeChildren(0,_centerGoodsListView.numChildren - 1);
            }
            _centerGoodsListView = new Sprite();
            _contentScrollPanel.beginChanges();
            _loc6_ = 0;
            while(_loc6_ < _loc3_.length)
            {
               _loc1_ = _loc3_[_loc6_] as LotteryRateInfo;
               _loc2_ = new SkyTreasureProItem();
               _loc2_.x = 2 + _loc6_ % _loc5_ * 250;
               _loc2_.y = int(_loc6_ / _loc5_) * 100;
               _loc2_.data = _loc1_;
               _centerGoodsListView.addChild(_loc2_);
               _loc6_++;
            }
            _contentScrollPanel.setView(_centerGoodsListView);
            _contentScrollPanel.invalidateViewport();
            _contentScrollPanel.commitChanges();
            _contentScrollPanel.viewPort.viewPosition = _loc4_;
         }
      }
      
      private function __frameResponse(param1:FrameEvent) : void
      {
         switch(int(param1.responseCode))
         {
            case 0:
            case 1:
               dispose();
         }
      }
      
      public function show(param1:SkyTreasureActTemplateInfo) : void
      {
         _act = param1;
         __panelChangeHandler();
         titleText = LanguageMgr.GetTranslation("skyTreasure.probabilityBtnTXT");
         LayerManager.Instance.addToLayer(this,3,true,true,1);
      }
      
      override public function get groups() : Array
      {
         return ["CASTLE_BUIDING_GROUP","MAIN_TOOLS_GROUP"];
      }
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,810,630);
      }
      
      override public function dispose() : void
      {
         removeEvent();
         uninitView();
         super.dispose();
      }
   }
}

