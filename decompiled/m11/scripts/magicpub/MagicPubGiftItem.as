package magicpub
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import yishi.datas.goods.GoodsInfo;
   import yishi.filter.UIFilter;
   import yishi.view.community.BaseItemView;
   
   public class MagicPubGiftItem extends Component
   {
      
      private var _goodsTemId:int;
      
      private var _count:int;
      
      private var _icon:BaseItemView;
      
      private var _back:ScaleBitmapImage;
      
      private var _frameFilter:Array;
      
      private var _selectGoodPlay:MovieClip;
      
      private var _countTxt:FilterFrameText;
      
      public function MagicPubGiftItem()
      {
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         _icon = ComponentFactory.Instance.creatCustomObject("magicpub.switchGoodCell");
         _back = ComponentFactory.Instance.creatComponentByStylename("magicpub.resolveBack");
         _selectGoodPlay = ComponentFactory.Instance.creatCustomObject("asset.magicpub.selectGoodPlay");
         _countTxt = ComponentFactory.Instance.creatComponentByStylename("magicpub.resolveMaterialNumTxt");
         _frameFilter = [UIFilter.getLightingFilter()];
         addChild(_back);
         addChild(_icon);
         addChild(_countTxt);
         addChild(_selectGoodPlay);
         stop();
         _icon.icon.tipStyle = "yishi.view.tips.goods.PropTips";
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
         if(_goodsTemId != 0)
         {
            _loc2_ = new GoodsInfo();
            _loc2_.templateId = _goodsTemId;
            _loc2_.isBinds = true;
            _icon.data = _loc2_;
            _icon.icon.tipData = _loc2_;
            buttonMode = true;
         }
         else
         {
            _icon.data = null;
            _icon.icon.tipData = null;
            buttonMode = false;
            _countTxt.text = "";
         }
      }
      
      public function get templeteId() : int
      {
         return _goodsTemId;
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
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_icon);
         _icon = null;
         ObjectUtils.disposeObject(_back);
         _back = null;
         ObjectUtils.disposeViolentMc(_selectGoodPlay);
         _selectGoodPlay = null;
         ObjectUtils.disposeObject(_countTxt);
         _countTxt = null;
         _frameFilter = null;
         super.dispose();
      }
   }
}

