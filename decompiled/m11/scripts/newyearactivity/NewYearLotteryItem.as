package newyearactivity
{
   import com.greensock.TweenLite;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import events.NewYearLotteryEvent;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.events.Event;
   import newyearact.NewYearLotteryModel;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.templates.GoodsTemplateInfo;
   import yishi.manager.NewYearActManager;
   import yishi.manager.TempleteManager;
   import yishi.view.community.BaseItemView;
   
   public class NewYearLotteryItem extends Component
   {
      
      private var _temId:int;
      
      private var _boxItem:BaseItemView;
      
      private var _selectBg:Bitmap;
      
      private var _index:int;
      
      private var _countTxt:FilterFrameText;
      
      private var _selected:Boolean;
      
      private var _delayTime:Number;
      
      private var _flickerEffct:MovieClip;
      
      private var _itemNullBg:Bitmap;
      
      private var _model:NewYearLotteryModel;
      
      public function NewYearLotteryItem()
      {
         super();
         _model = NewYearActManager.instance.lotteryModel;
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _boxItem = ComponentFactory.Instance.creatCustomObject("newyearact.NewYearLotteryItem.GoodsItem");
         _selectBg = ComponentFactory.Instance.creatBitmap("asset.newyearact.ItemSelect");
         _itemNullBg = ComponentFactory.Instance.creatBitmap("asset.newyearact.ItemNullBg");
         _flickerEffct = ComponentFactory.Instance.creatCustomObject("newyearact.NewYearLotteryItem.GoodsFlickerEffctMC");
         _countTxt = ComponentFactory.Instance.creatComponentByStylename("newyearact.NewYearLotteryItem.ItemCountTxt");
         _itemNullBg.visible = false;
         _flickerEffct.gotoAndStop(1);
         _flickerEffct.visible = false;
         _selectBg.visible = false;
         addChild(_boxItem);
         addChild(_countTxt);
         addChild(_selectBg);
         addChild(_itemNullBg);
         addChild(_flickerEffct);
      }
      
      private function uninitView() : void
      {
         ObjectUtils.disposeObject(_boxItem);
         _boxItem = null;
         ObjectUtils.disposeObject(_selectBg);
         _selectBg = null;
         ObjectUtils.disposeObject(_countTxt);
         _countTxt = null;
         ObjectUtils.disposeObject(_flickerEffct);
         _flickerEffct = null;
         ObjectUtils.disposeObject(_itemNullBg);
         _itemNullBg = null;
         ObjectUtils.disposeAllChildren(this);
      }
      
      public function set Index(param1:int) : void
      {
         _index = param1;
      }
      
      public function get Index() : int
      {
         return _index;
      }
      
      public function set count(param1:int) : void
      {
         var _loc2_:int = 0;
         if(param1 > 1)
         {
            _loc2_ = param1 / 10000;
            if(_loc2_ >= 1)
            {
               _countTxt.text = _loc2_ + "0K";
            }
            else
            {
               _countTxt.text = param1.toString();
            }
         }
      }
      
      private function initEvent() : void
      {
      }
      
      private function removeEvent() : void
      {
         StageReferance.stage.removeEventListener("enterFrame",_stageFrame);
      }
      
      public function set data(param1:int) : void
      {
         var _loc2_:GoodsInfo = null;
         _temId = param1;
         var _loc3_:GoodsTemplateInfo = TempleteManager.instance.goodsTemplateCate.getTemplateByID(_temId);
         if(_loc3_)
         {
            _loc2_ = new GoodsInfo();
            _loc2_.templateId = _temId;
            _boxItem.data = _loc2_;
         }
         else
         {
            _boxItem.data = null;
         }
      }
      
      public function set selected(param1:Boolean) : void
      {
         _selected = param1;
         _delayTime = _model.delayTime * 0.002;
         if(_selected)
         {
            _selectBg.alpha = 1;
            _selectBg.visible = true;
            _delayTime = _model.delayTime > 400 ? 0.8 : _model.delayTime * 0.002;
            if(_delayTime)
            {
               setTween();
            }
         }
         else if(!_delayTime)
         {
            _selectBg.visible = false;
         }
      }
      
      private function setTween() : void
      {
         TweenLite.killTweensOf(_selectBg);
         _selectBg.alpha = 0;
         var _loc1_:Number = _delayTime;
         if(_delayTime >= 0.6)
         {
            _loc1_ = 0.3;
         }
         if(_delayTime >= 0.8)
         {
            _loc1_ = 0.05;
         }
         TweenLite.to(_selectBg,_loc1_ + 0.2,{
            "alpha":1,
            "onComplete":hideBg
         });
      }
      
      private function hideBg() : void
      {
         hideMoveBg(_delayTime);
      }
      
      public function hideMoveBg(param1:Number) : void
      {
         if(_selectBg)
         {
            TweenLite.to(_selectBg,param1,{"alpha":0});
         }
      }
      
      public function flicker() : void
      {
         _selectBg.visible = false;
         _flickerEffct.visible = true;
         _flickerEffct.gotoAndPlay(1);
         StageReferance.stage.addEventListener("enterFrame",_stageFrame);
      }
      
      private function _stageFrame(param1:Event) : void
      {
         if(_flickerEffct.currentFrame == _flickerEffct.totalFrames)
         {
            _flickerEffct.visible = false;
            _flickerEffct.gotoAndStop(1);
            StageReferance.stage.removeEventListener("enterFrame",_stageFrame);
            _model.dispatchEvent(new NewYearLotteryEvent("LOTTERY_EFFCT_COMPLETE"));
         }
      }
      
      override public function dispose() : void
      {
         TweenLite.killTweensOf(_selectBg);
         removeEvent();
         uninitView();
         _model = null;
         super.dispose();
      }
   }
}

