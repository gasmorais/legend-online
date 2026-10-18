package map.campaign.view.frame.dungeonturn
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import manager.LanguageMgr;
   import yishi.filter.UIFilter;
   
   public class TurnItem extends Component
   {
      
      private var _numTxt:FilterFrameText;
      
      private var _bored:Image;
      
      private var _selectBored:ScaleFrameImage;
      
      private var _power:ScaleFrameImage;
      
      private var _text:MutipleImage;
      
      private var _buffer:ScaleFrameImage;
      
      private var _filters:UIFilter;
      
      private var _canFigth:Boolean;
      
      public function TurnItem()
      {
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         _numTxt = ComponentFactory.Instance.creatComponentByStylename("dungeonturn.TurnItem.numTxt");
         _bored = ComponentFactory.Instance.creatComponentByStylename("dungeonturn.TurnItem.bored");
         _selectBored = ComponentFactory.Instance.creatComponentByStylename("dungeonturn.TurnItem.selectBored");
         _power = ComponentFactory.Instance.creatComponentByStylename("dungeonturn.TurnItem.power");
         _text = ComponentFactory.Instance.creatComponentByStylename("dungeonturn.TurnItem.text");
         _buffer = ComponentFactory.Instance.creatComponentByStylename("dungeonturn.TurnItem.buffer");
         addChild(_selectBored);
         addChild(_bored);
         addChild(_power);
         addChild(_buffer);
         addChild(_text);
         addChild(_numTxt);
         _selectBored.visible = false;
         _bored.visible = false;
         _filters = new UIFilter();
      }
      
      public function set data(param1:Object) : void
      {
      }
      
      public function setStatus(param1:int, param2:int, param3:int, param4:int) : void
      {
         _numTxt.text = "x" + param2 + "";
         _power.setFrame(param1);
         _canFigth = true;
         this.tipData = null;
         setSelectBored(false);
         switch(param3)
         {
            case 0:
               _buffer.visible = false;
               break;
            case 4:
            case 5:
               _buffer.setFrame(param3 - 3);
               this.tipData = LanguageMgr.GetTranslation("dungeonturn.TurnItem.buffer.tipdata" + param3);
         }
         if(param4 == 0)
         {
            _text.visible = false;
         }
         else
         {
            _canFigth = false;
            _filters.setGrayFilter(_buffer);
            _filters.setGrayFilter(_power);
            _text.visible = true;
            _text.showImg(1);
         }
      }
      
      public function canFight() : Boolean
      {
         return _canFigth;
      }
      
      public function setStart() : void
      {
         _text.showImg(0);
         _numTxt.visible = false;
         _buffer.visible = false;
         _power.visible = false;
         setSelectBored(false);
      }
      
      public function setAgain() : void
      {
         _text.showImg(3);
         _numTxt.visible = false;
         _buffer.visible = false;
         _power.visible = false;
         setSelectBored(false);
      }
      
      public function setBoss() : void
      {
         _canFigth = true;
         _text.showImg(4);
         _numTxt.visible = false;
         _buffer.visible = false;
         _power.visible = false;
         setSelectBored(true);
      }
      
      public function setRestart() : void
      {
         _text.showImg(2);
         _numTxt.visible = false;
         _buffer.visible = false;
         _power.visible = false;
         setSelectBored(false);
      }
      
      public function select() : void
      {
         _selectBored.visible = true;
      }
      
      public function cancelSelect() : void
      {
         _selectBored.visible = false;
      }
      
      private function setSelectBored(param1:Boolean) : void
      {
         if(param1)
         {
            _selectBored.setFrame(2);
            _selectBored.x = 7;
            _selectBored.y = 3;
            _bored.visible = false;
         }
         else
         {
            _selectBored.setFrame(1);
            _selectBored.x = 0;
            _selectBored.y = -1;
            _bored.visible = true;
         }
      }
      
      private function addEvent() : void
      {
      }
      
      private function removeEvent() : void
      {
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_numTxt);
         _numTxt = null;
         ObjectUtils.disposeObject(_bored);
         _bored = null;
         ObjectUtils.disposeObject(_selectBored);
         _selectBored = null;
         ObjectUtils.disposeObject(_power);
         _power = null;
         ObjectUtils.disposeObject(_text);
         _text = null;
         ObjectUtils.disposeObject(_buffer);
         _buffer = null;
         _filters = null;
         super.dispose();
      }
   }
}

