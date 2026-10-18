package bingo
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.road.yishi.proto.bingo.BingoBuyDetailMsg;
   import com.road.yishi.proto.bingo.BingoCardTempMsg;
   import com.road.yishi.proto.bingo.BingoResultDataMsg;
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import yishi.events.NotificationEvent;
   import yishi.manager.BingoManager;
   import yishi.manager.NotificationManager;
   import yishi.utils.NumberViewUtils;
   
   public class BingoNumView extends Component
   {
      
      private var _numberBg:DisplayObject;
      
      private var _lineSprite:Sprite;
      
      private var _linesick:int;
      
      private var _data:BingoBuyDetailMsg;
      
      private var _numTxt1:FilterFrameText;
      
      private var _numTxt2:FilterFrameText;
      
      private var _numberContain:Component;
      
      private var _numberAsset:BitmapData;
      
      private var _itemList:Array = [];
      
      private var _resultMsg:BingoResultDataMsg;
      
      private var _buyInputBg1:Image;
      
      private var _buyInputBg2:Image;
      
      private var _xingyunshuzi2:Image;
      
      private var _mulImage:ScaleFrameImage;
      
      private var _index:int;
      
      public function BingoNumView()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         var _loc2_:int = 0;
         var _loc1_:BingoNumItem = null;
         _numberBg = ComponentFactory.Instance.creatBitmap("asset.bingo.numBg");
         _numberAsset = ComponentFactory.Instance.creatBitmapData("asset.bingo.cardTitleNumAsset");
         _xingyunshuzi2 = ComponentFactory.Instance.creatComponentByStylename("bingo.xingyunshuzi2");
         _numberContain = new Component();
         _lineSprite = ComponentFactory.Instance.creatCustomObject("bingo.scene.lineSprite");
         _buyInputBg1 = ComponentFactory.Instance.creatComponentByStylename("bingo.BuyInputBg1");
         _buyInputBg2 = ComponentFactory.Instance.creatComponentByStylename("bingo.BuyInputBg2");
         _numTxt1 = ComponentFactory.Instance.creatComponentByStylename("bingo.BingoNumView.numTxt1");
         _numTxt2 = ComponentFactory.Instance.creatComponentByStylename("bingo.BingoNumView.numTxt2");
         _mulImage = ComponentFactory.Instance.creatComponentByStylename("bingo.rewardMulImage");
         addChild(_numberBg);
         _loc2_ = 0;
         while(_loc2_ < 25)
         {
            _loc1_ = new BingoNumItem();
            _loc1_.x = 42 + int(_loc2_ % 5) * 50;
            _loc1_.y = 90 + int(_loc2_ / 5) * 50;
            addChild(_loc1_);
            _itemList.push(_loc1_);
            _loc2_++;
         }
         addChild(_numberContain);
         addChild(_xingyunshuzi2);
         addChild(_buyInputBg1);
         addChild(_buyInputBg2);
         addChild(_numTxt1);
         addChild(_numTxt2);
         addChild(_lineSprite);
         addChild(_mulImage);
         this.visible = false;
         _mulImage.visible = false;
      }
      
      public function set index(param1:int) : void
      {
         _index = param1;
      }
      
      public function set data(param1:BingoBuyDetailMsg) : void
      {
         var _loc3_:int = 0;
         _data = param1;
         this.visible = _data ? true : false;
         if(!_data)
         {
            return;
         }
         var _loc2_:BingoCardTempMsg = BingoManager.instance.getCardTempById(_data.cardId);
         _loc3_ = 0;
         while(_loc3_ < _itemList.length)
         {
            _itemList[_loc3_].data = _loc2_.cardNum[_loc3_];
            _loc3_++;
         }
         NumberViewUtils.refreshValue(_data.cardId,_numberContain,_numberAsset,28,39,25,28,"0123456789");
         _numberContain.x = (_numberBg.width - _numberContain.displayWidth) / 2;
         _numberContain.y = 10;
         _numTxt1.text = String(_data.luckNum[0]);
         _numTxt2.text = String(_data.luckNum[1]);
         __ballStartHandler(null);
      }
      
      private function initEvent() : void
      {
         NotificationManager.instance.addEventListener("BALL_START",__ballStartHandler);
      }
      
      private function removeEvent() : void
      {
         NotificationManager.instance.removeEventListener("BALL_START",__ballStartHandler);
      }
      
      private function __ballStartHandler(param1:NotificationEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:Array = null;
         var _loc4_:Array = null;
         _mulImage.visible = false;
         _resultMsg = BingoManager.instance.resultMsg;
         if(_resultMsg && _data)
         {
            if(_resultMsg.luckNum.indexOf(_data.luckNum[0]) != -1)
            {
               _numTxt1.setFrame(2);
               _loc2_++;
            }
            else
            {
               _numTxt1.setFrame(1);
            }
            if(_resultMsg.luckNum.indexOf(_data.luckNum[1]) != -1)
            {
               _numTxt2.setFrame(2);
               _loc2_++;
            }
            else
            {
               _numTxt2.setFrame(1);
            }
            if(_loc2_ > 0)
            {
               _mulImage.visible = true;
               _mulImage.setFrame(_loc2_);
            }
         }
         if(isBingo)
         {
            _loc3_ = [0,0];
            _loc4_ = [0,0];
            if(row1)
            {
               _loc3_ = [48,117];
               _loc4_ = [285,117];
            }
            if(row2)
            {
               _loc3_ = [48,166];
               _loc4_ = [285,166];
            }
            if(row3)
            {
               _loc3_ = [48,213];
               _loc4_ = [285,213];
            }
            if(row4)
            {
               _loc3_ = [48,262];
               _loc4_ = [285,262];
            }
            if(row5)
            {
               _loc3_ = [48,312];
               _loc4_ = [285,312];
            }
            if(col1)
            {
               _loc3_ = [68,96];
               _loc4_ = [68,331];
            }
            if(col2)
            {
               _loc3_ = [118,96];
               _loc4_ = [118,331];
            }
            if(col3)
            {
               _loc3_ = [168,96];
               _loc4_ = [168,331];
            }
            if(col4)
            {
               _loc3_ = [218,96];
               _loc4_ = [218,331];
            }
            if(col5)
            {
               _loc3_ = [268,96];
               _loc4_ = [268,331];
            }
            if(diag1)
            {
               _loc3_ = [48,96];
               _loc4_ = [284,329];
            }
            if(diag2)
            {
               _loc3_ = [50,330];
               _loc4_ = [286,99];
            }
            _linesick = 5;
            _lineSprite.graphics.lineStyle(_linesick,16711680,1);
            _lineSprite.graphics.moveTo(_loc3_[0],_loc3_[1]);
            _lineSprite.graphics.lineTo(_loc4_[0],_loc4_[1]);
            _lineSprite.graphics.endFill();
            _lineSprite.visible = true;
            if(param1 && !BingoManager.instance.isPlaying[_index])
            {
               BingoManager.instance.isPlaying[_index] = 1;
               NotificationManager.instance.dispatchEvent(new NotificationEvent("BALL_WIN_MOVIE"));
            }
         }
         else
         {
            _lineSprite.visible = false;
         }
      }
      
      private function get row1() : Boolean
      {
         return _itemList[0].marked && _itemList[1].marked && _itemList[2].marked && _itemList[3].marked && _itemList[4].marked;
      }
      
      private function get row2() : Boolean
      {
         return _itemList[5].marked && _itemList[6].marked && _itemList[7].marked && _itemList[8].marked && _itemList[9].marked;
      }
      
      private function get row3() : Boolean
      {
         return _itemList[10].marked && _itemList[11].marked && _itemList[12].marked && _itemList[13].marked && _itemList[14].marked;
      }
      
      private function get row4() : Boolean
      {
         return _itemList[15].marked && _itemList[16].marked && _itemList[17].marked && _itemList[18].marked && _itemList[19].marked;
      }
      
      private function get row5() : Boolean
      {
         return _itemList[20].marked && _itemList[21].marked && _itemList[22].marked && _itemList[23].marked && _itemList[24].marked;
      }
      
      private function get col1() : Boolean
      {
         return _itemList[0].marked && _itemList[5].marked && _itemList[10].marked && _itemList[15].marked && _itemList[20].marked;
      }
      
      private function get col2() : Boolean
      {
         return _itemList[1].marked && _itemList[6].marked && _itemList[11].marked && _itemList[16].marked && _itemList[21].marked;
      }
      
      private function get col3() : Boolean
      {
         return _itemList[2].marked && _itemList[7].marked && _itemList[12].marked && _itemList[17].marked && _itemList[22].marked;
      }
      
      private function get col4() : Boolean
      {
         return _itemList[3].marked && _itemList[8].marked && _itemList[13].marked && _itemList[18].marked && _itemList[23].marked;
      }
      
      private function get col5() : Boolean
      {
         return _itemList[4].marked && _itemList[9].marked && _itemList[14].marked && _itemList[19].marked && _itemList[24].marked;
      }
      
      private function get diag1() : Boolean
      {
         return _itemList[0].marked && _itemList[6].marked && _itemList[12].marked && _itemList[18].marked && _itemList[24].marked;
      }
      
      private function get diag2() : Boolean
      {
         return _itemList[4].marked && _itemList[8].marked && _itemList[12].marked && _itemList[16].marked && _itemList[20].marked;
      }
      
      private function get isBingo() : Boolean
      {
         if(row1 || row2 || row3 || row4 || row5 || col1 || col2 || col3 || col4 || col5 || diag1 || diag2)
         {
            return true;
         }
         return false;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_numberBg);
         _numberBg = null;
         ObjectUtils.disposeObject(_lineSprite);
         _lineSprite = null;
         ObjectUtils.disposeObject(_numTxt1);
         _numTxt1 = null;
         ObjectUtils.disposeObject(_numTxt2);
         _numTxt2 = null;
         ObjectUtils.disposeObject(_numberContain);
         _numberContain = null;
         ObjectUtils.disposeObject(_numberAsset);
         _numberAsset = null;
         ObjectUtils.disposeObject(_buyInputBg1);
         _buyInputBg1 = null;
         ObjectUtils.disposeObject(_buyInputBg2);
         _buyInputBg2 = null;
         ObjectUtils.disposeObject(_xingyunshuzi2);
         _xingyunshuzi2 = null;
         ObjectUtils.disposeObject(_mulImage);
         _mulImage = null;
         if(_itemList)
         {
            while(_itemList.length)
            {
               ObjectUtils.disposeObject(_itemList.pop());
            }
         }
         _data = null;
         _resultMsg = null;
         _itemList = null;
         super.dispose();
      }
   }
}

