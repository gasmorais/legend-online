package luckylottery
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.MovieClip;
   import managers.LuckyLotteryManager;
   import mvc.module.luckylottery.LuckyLotteryGoodsInfo;
   import mvc.module.luckylottery.LuckyLotteryModel;
   import yishi.datas.goods.GoodsInfo;
   import yishi.view.community.BaseItemView;
   
   public class LuckyLotteryGoodsItem extends Component
   {
      
      private var _baseItem:BaseItemView;
      
      private var _numbeTxt:FilterFrameText;
      
      private var _flag:MovieClip;
      
      private var _selctedMc:MovieClip;
      
      private var _data:LuckyLotteryGoodsInfo;
      
      private var _model:LuckyLotteryModel;
      
      public function LuckyLotteryGoodsItem()
      {
         super();
         _model = LuckyLotteryManager.instance.model;
         initView();
      }
      
      private function initView() : void
      {
         _baseItem = ComponentFactory.Instance.creatCustomObject("LuckyLotteryGoodsItem.baseItemView");
         _numbeTxt = ComponentFactory.Instance.creatComponentByStylename("LuckyLotteryGoodsItem.numbeTxt");
         _flag = ComponentFactory.Instance.creatCustomObject("LuckyLotteryGoodsItem.flag");
         _selctedMc = ComponentFactory.Instance.creatCustomObject("LuckyLotteryGoodsItem.selctedMc");
         addChild(_baseItem);
         addChild(_numbeTxt);
         addChild(_flag);
         addChild(_selctedMc);
         _flag.visible = false;
         _flag.mouseChildren = _flag.mouseEnabled = false;
         _flag.gotoAndStop(1);
         _selctedMc.visible = false;
         _selctedMc.mouseChildren = _selctedMc.mouseEnabled = false;
         _selctedMc.gotoAndStop(1);
      }
      
      public function set data(param1:LuckyLotteryGoodsInfo) : void
      {
         var goodsInfo:GoodsInfo;
         var value:LuckyLotteryGoodsInfo = param1;
         _data = value;
         if(_data)
         {
            goodsInfo = new GoodsInfo();
            goodsInfo.templateId = _data.templateId;
            goodsInfo.showCount = true;
            goodsInfo.count = _data.count;
            _baseItem.data = goodsInfo;
            _numbeTxt.text = _data.currentNum + "/" + _data.maxNum;
            if(_data.index == 1 && _data.label == 1)
            {
               _flag.visible = true;
               _flag.gotoAndPlay(1);
            }
            else if(_data.selected)
            {
               _selctedMc.visible = true;
               _selctedMc.gotoAndPlay(1);
               _selctedMc.addFrameScript(23,function():void
               {
                  _selctedMc.gotoAndStop(1);
                  _selctedMc.visible = false;
               });
            }
         }
         else
         {
            clear();
         }
      }
      
      private function clear() : void
      {
         _baseItem.data = null;
         _numbeTxt.text = "";
         if(_flag)
         {
            _flag.visible = false;
            _flag.gotoAndStop(1);
         }
         if(_selctedMc)
         {
            _selctedMc.visible = false;
            _selctedMc.gotoAndStop(1);
         }
      }
      
      override public function dispose() : void
      {
         ObjectUtils.disposeObject(_baseItem);
         _baseItem = null;
         ObjectUtils.disposeObject(_numbeTxt);
         _numbeTxt = null;
         ObjectUtils.disposeViolentMc(_flag);
         _flag = null;
         ObjectUtils.disposeViolentMc(_selctedMc);
         _selctedMc = null;
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
         super.dispose();
      }
   }
}

