package bingo
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.DisplayObject;
   import flash.events.MouseEvent;
   import yishi.datas.ConfigInfoManager;
   
   public class BingoResultItem extends Component
   {
      
      private var _overBg:DisplayObject;
      
      private var _image:Image;
      
      private var _lotteryNumTxt:FilterFrameText;
      
      private var _everyLotteryTxt:FilterFrameText;
      
      private var _totalLevelTxt:FilterFrameText;
      
      private var _redStone3:Image;
      
      private var _redStone4:Image;
      
      private var _index:int;
      
      private var _overLight:Scale9CornerImage;
      
      public function BingoResultItem()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _overBg = ComponentFactory.Instance.creatComponentByStylename("bingo.BetListCellOverBg");
         _image = ComponentFactory.Instance.creatComponentByStylename("bingo.result.rankImage");
         _lotteryNumTxt = ComponentFactory.Instance.creatComponentByStylename("bingo.lotteryNumTxt");
         _everyLotteryTxt = ComponentFactory.Instance.creatComponentByStylename("bingo.everyLotteryTxt");
         _totalLevelTxt = ComponentFactory.Instance.creatComponentByStylename("bingo.totalLevelTxt");
         _redStone3 = ComponentFactory.Instance.creatComponentByStylename("bingo.redStone3");
         _redStone4 = ComponentFactory.Instance.creatComponentByStylename("bingo.redStone4");
         addChild(_overBg);
         addChild(_image);
         addChild(_lotteryNumTxt);
         addChild(_everyLotteryTxt);
         addChild(_totalLevelTxt);
         addChild(_redStone3);
         addChild(_redStone4);
         _overBg.visible = false;
         _image.visible = false;
         _redStone3.visible = false;
         _redStone4.visible = false;
      }
      
      public function set index(param1:int) : void
      {
         _index = param1;
      }
      
      public function set data(param1:Array) : void
      {
         _image.visible = true;
         _image.setFrame(param1[0]);
         _redStone3.visible = true;
         _redStone4.visible = true;
         _lotteryNumTxt.text = String(param1[1]);
         _totalLevelTxt.text = String(param1[2]);
         var _loc3_:Array = ConfigInfoManager.instance.getBingoPLimit();
         var _loc2_:int = param1[2] / param1[1];
         _loc2_ = _loc2_ >= int(_loc3_[_index]) ? int(_loc3_[_index]) : _loc2_;
         _everyLotteryTxt.text = _loc2_.toString();
      }
      
      private function initEvent() : void
      {
         addEventListener("rollOver",__rollOverHandler);
         addEventListener("rollOut",__rollOutHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("rollOver",__rollOverHandler);
         removeEventListener("rollOut",__rollOutHandler);
      }
      
      private function __rollOverHandler(param1:MouseEvent) : void
      {
         _overBg.visible = true;
      }
      
      private function __rollOutHandler(param1:MouseEvent) : void
      {
         _overBg.visible = false;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_overBg);
         _overBg = null;
         ObjectUtils.disposeObject(_image);
         _image = null;
         ObjectUtils.disposeObject(_lotteryNumTxt);
         _lotteryNumTxt = null;
         ObjectUtils.disposeObject(_everyLotteryTxt);
         _everyLotteryTxt = null;
         ObjectUtils.disposeObject(_totalLevelTxt);
         _totalLevelTxt = null;
         ObjectUtils.disposeObject(_redStone3);
         _redStone3 = null;
         ObjectUtils.disposeObject(_redStone4);
         _redStone4 = null;
         ObjectUtils.disposeObject(_overLight);
         _overLight = null;
         super.dispose();
      }
   }
}

