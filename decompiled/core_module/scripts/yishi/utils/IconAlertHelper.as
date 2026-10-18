package yishi.utils
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.SelectedCheckButton;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import yishi.datas.goods.GoodsInfo;
   import yishi.keyboard.KeyBoardRegister;
   import yishi.view.community.BaseItemView;
   
   public class IconAlertHelper extends Component
   {
      
      private static var _instance:IconAlertHelper;
      
      private var _frame:Frame;
      
      private var _alertTxt:FilterFrameText;
      
      private var _item:BaseItemView;
      
      private var _goodsCountTxt:FilterFrameText;
      
      private var _confirmBtn:SelectedCheckButton;
      
      private var _cancleBtn:SelectedCheckButton;
      
      private var _data:Array;
      
      private var _frameMinW:int = 316;
      
      private var _frameMinH:int = 192;
      
      private var _buttonGap:int = 5;
      
      private var _rowSpace:int = 5;
      
      private var _buttonToBottom:int = 65;
      
      public function IconAlertHelper()
      {
         super();
      }
      
      public static function get instance() : IconAlertHelper
      {
         if(_instance == null)
         {
            _instance = new IconAlertHelper();
         }
         return _instance;
      }
      
      private function initView() : void
      {
         _frame = ComponentFactory.Instance.creatComponentByStylename("IconAlert");
         _alertTxt = ComponentFactory.Instance.creatComponentByStylename("IconAlertContentText");
         _confirmBtn = ComponentFactory.Instance.creatComponentByStylename("core.AlertConfirmBtn_2");
         _cancleBtn = ComponentFactory.Instance.creatComponentByStylename("core.AlertButton_2");
         addChild(_frame);
         _frame.addToContent(_alertTxt);
         _frame.addToContent(_confirmBtn);
         _frame.addToContent(_cancleBtn);
      }
      
      private function addEvent() : void
      {
         _frame.addEventListener("response",__frameResponseHandler);
         _confirmBtn.addEventListener("click",__confirmClick);
         _cancleBtn.addEventListener("click",__cancleClick);
      }
      
      private function removeEvent() : void
      {
         if(_frame)
         {
            _frame.removeEventListener("response",__frameResponseHandler);
         }
         if(_confirmBtn)
         {
            _confirmBtn.removeEventListener("click",__confirmClick);
         }
         if(_cancleBtn)
         {
            _cancleBtn.removeEventListener("click",__cancleClick);
         }
      }
      
      private function __frameResponseHandler(param1:FrameEvent) : void
      {
         switch(param1.responseCode - 2)
         {
            case 0:
               succeedBack();
               dispose();
               break;
            default:
               failBack();
               dispose();
         }
      }
      
      private function __confirmClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         succeedBack();
         dispose();
      }
      
      private function __cancleClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         failBack();
         dispose();
      }
      
      private function succeedBack() : void
      {
         if(!_data || _data.length < 1)
         {
            return;
         }
         var _loc1_:Function = _data[0] as Function;
         backCall(_loc1_,true);
         _loc1_ = null;
      }
      
      private function failBack() : void
      {
         if(!_data || _data.length < 1)
         {
            return;
         }
         var _loc1_:Function = _data[0] as Function;
         backCall(_loc1_,false);
         _loc1_ = null;
      }
      
      private function backCall(param1:Function, param2:Boolean) : void
      {
         var _loc3_:String = LanguageMgr.GetTranslation("yishi.utils.IconAlertHelper.CanFiveParams");
         if(param1 == null)
         {
            return;
         }
         switch(_data.length - 1)
         {
            case 0:
               param1(param2);
               break;
            case 1:
               param1(param2,_data[1]);
               break;
            case 2:
               param1(param2,_data[1],_data[2]);
               break;
            case 3:
               param1(param2,_data[1],_data[2],_data[3]);
               break;
            case 4:
               param1(param2,_data[1],_data[2],_data[3],_data[4]);
               break;
            case 5:
               param1(param2,_data[1],_data[2],_data[3],_data[4],_data[5]);
               break;
            default:
               throw new Error(_loc3_);
         }
         cleanData();
      }
      
      private function cleanData() : void
      {
         if(_data)
         {
            while(_data.length > 0)
            {
               _data.pop();
            }
            _data = null;
         }
      }
      
      private function updatePos() : void
      {
         if(_alertTxt.width <= _frameMinW - 70)
         {
            _frame.width = _frameMinW;
            _alertTxt.x = (_frameMinW - 70) / 2 - _alertTxt.width / 2;
            if(_item)
            {
               _item.x = (_frameMinW - 70) / 2 - _item.displayWidth + 10;
               _goodsCountTxt.x = _item.x + _item.displayWidth;
            }
            _confirmBtn.x = _buttonGap;
            _cancleBtn.x = _frameMinW - 70 - _cancleBtn.width - _buttonGap;
         }
         else
         {
            _frame.width = _alertTxt.width + 70;
            if(_item)
            {
               _item.x = _frame.width / 2 - _item.displayWidth + 10;
               _goodsCountTxt.x = _item.x + _item.displayWidth;
            }
            _confirmBtn.x = (_frame.width - _frameMinW) / 4 + _buttonGap;
            _cancleBtn.x = _frame.width - 70 - (_frame.width - _frameMinW) / 4 - _cancleBtn.width - _buttonGap;
         }
         _alertTxt.y = 5;
         if(_item)
         {
            _item.y = _alertTxt.y + _alertTxt.height + _rowSpace;
            _goodsCountTxt.y = _item.y + 24;
            _confirmBtn.y = _cancleBtn.y = _item.y + 55;
         }
         else
         {
            _confirmBtn.y = _cancleBtn.y = _alertTxt.y + _alertTxt.height + 20;
         }
         _frame.height = _confirmBtn.y + 115;
      }
      
      public function set data(param1:Array) : void
      {
         _data = param1;
      }
      
      public function popAlertFrame(param1:String, param2:String, param3:int, param4:int, param5:String, param6:String, param7:Boolean = false, param8:int = 2) : void
      {
         var _loc9_:GoodsInfo = null;
         initView();
         addEvent();
         _frame.titleText = param1;
         if(param7)
         {
            _alertTxt.htmlText = param2;
         }
         else
         {
            _alertTxt.text = param2;
         }
         if(param3)
         {
            _loc9_ = new GoodsInfo();
            _loc9_.templateId = param3;
            _item = ComponentFactory.Instance.creatCustomObject("IconAlertBaseItem");
            _goodsCountTxt = ComponentFactory.Instance.creatComponentByStylename("IconAlertContentText");
            _item.data = _loc9_;
            _goodsCountTxt.text = " x " + String(param4);
            _frame.addToContent(_item);
            _frame.addToContent(_goodsCountTxt);
         }
         updatePos();
         LayerManager.Instance.addToLayer(this,3,true,true,param8,0,false,1);
         KeyBoardRegister.instance.keyEnable = false;
      }
      
      override public function dispose() : void
      {
         KeyBoardRegister.instance.keyEnable = true;
         removeEvent();
         ObjectUtils.disposeAllChildren(this);
         if(_frame)
         {
            _frame.dispose();
            _frame = null;
         }
         if(_alertTxt)
         {
            _alertTxt.dispose();
            _alertTxt = null;
         }
         if(_item)
         {
            _item.dispose();
            _item = null;
         }
         if(_goodsCountTxt)
         {
            _goodsCountTxt.dispose();
            _goodsCountTxt = null;
         }
         if(_confirmBtn)
         {
            _confirmBtn.dispose();
            _confirmBtn = null;
         }
         if(_cancleBtn)
         {
            _cancleBtn.dispose();
            _cancleBtn = null;
         }
         cleanData();
         super.dispose();
      }
   }
}

