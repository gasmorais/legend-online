package store.switched
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import yishi.datas.goods.GoodsInfo;
   import yishi.filter.UIFilter;
   import yishi.view.community.BaseItemView;
   
   public class SwitchItem extends Sprite implements Disposeable
   {
      
      private var _goodsTemId:int;
      
      private var _parentTemId:int;
      
      private var _count:int;
      
      private var _icon:BaseItemView;
      
      private var _back:ScaleBitmapImage;
      
      private var _textImg:Bitmap;
      
      private var _frameFilter:Array;
      
      private var _selectGoodPlay:MovieClip;
      
      private var _countTxt:FilterFrameText;
      
      public function SwitchItem()
      {
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         _icon = ComponentFactory.Instance.creatCustomObject("store.switchGoodCell");
         _back = ComponentFactory.Instance.creatComponentByStylename("store.resolveBack");
         _selectGoodPlay = ComponentFactory.Instance.creatCustomObject("asset.store.selectGoodPlay");
         _countTxt = ComponentFactory.Instance.creatComponentByStylename("store.resolveMaterialNumTxt");
         _textImg = ComponentFactory.Instance.creatBitmap("asset.store.GoodWordTxtImg");
         _textImg.x = 8;
         _textImg.y = 15;
         _frameFilter = [UIFilter.getLightingFilter()];
         addChild(_back);
         addChild(_textImg);
         addChild(_icon);
         addChild(_countTxt);
         addChild(_selectGoodPlay);
         stop();
         _selectGoodPlay.mouseChildren = false;
         _selectGoodPlay.mouseEnabled = false;
      }
      
      private function addEvent() : void
      {
         addEventListener("mouseMove",__overHandler);
         addEventListener("mouseOut",__outHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("mouseMove",__overHandler);
         removeEventListener("mouseOut",__outHandler);
      }
      
      public function set data(param1:int) : void
      {
         var _loc2_:GoodsInfo = null;
         _goodsTemId = param1;
         if(_goodsTemId > 0)
         {
            _loc2_ = new GoodsInfo();
            _loc2_.templateId = _goodsTemId;
            _loc2_.isBinds = true;
            _icon.data = _loc2_;
            buttonMode = true;
         }
         else
         {
            _icon.data = null;
            buttonMode = false;
            _countTxt.text = "";
         }
      }
      
      public function get templeteId() : int
      {
         return _goodsTemId;
      }
      
      public function get parentTemId() : int
      {
         return _parentTemId;
      }
      
      public function set parentTemId(param1:int) : void
      {
         _parentTemId = param1;
      }
      
      public function get count() : int
      {
         return _count;
      }
      
      public function set count(param1:int) : void
      {
         if(_icon.data)
         {
            _countTxt.text = param1 + "";
            _count = param1;
         }
         else
         {
            _countTxt.text = "";
            _count = 0;
         }
      }
      
      private function __outHandler(param1:MouseEvent) : void
      {
         this.filters = null;
      }
      
      private function __overHandler(param1:MouseEvent) : void
      {
         if(_icon.data)
         {
            filters = _frameFilter;
         }
         else
         {
            filters = null;
         }
      }
      
      public function stop() : void
      {
         _selectGoodPlay.gotoAndStop(1);
      }
      
      public function play() : void
      {
         if(_icon.data)
         {
            _selectGoodPlay.gotoAndPlay(1);
         }
         else
         {
            _selectGoodPlay.gotoAndStop(1);
         }
      }
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeAllChildren(this);
      }
   }
}

