package customizedvip
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import managers.CustomizedVipManager;
   import mvc.ModuleFrameInfo;
   import mvc.module.customizedvip.CustomizedVipBoxInfo;
   import mvc.module.customizedvip.CustomizedVipModel;
   import utils.LogicUtils;
   import yishi.datas.ComponentGroupType;
   import yishi.utils.SimpleDictionary;
   import yishi.view.base.TokenAmountItem;
   
   public class CustomizedVipBuyFrame extends Frame
   {
      
      private var _bg:MutipleImage;
      
      private var _costItem:TokenAmountItem;
      
      private var _inputText:FilterFrameText;
      
      private var _addBtn:BaseButton;
      
      private var _delBtn:BaseButton;
      
      private var _limitText:FilterFrameText;
      
      private var _sureBtn:IconButton;
      
      private var buyNum:int = 1;
      
      private var _data:CustomizedVipBoxInfo;
      
      private var totalPrice:int;
      
      public function CustomizedVipBuyFrame()
      {
         super();
         initView();
         addEvent();
      }
      
      override public function get groups() : Array
      {
         return [ComponentGroupType.NONE];
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatComponentByStylename("CustomizedVipBuyFrame.bg");
         _costItem = ComponentFactory.Instance.creatComponentByStylename("CustomizedVipBuyFrame.costItem");
         _inputText = ComponentFactory.Instance.creatComponentByStylename("CustomizedVipBuyFrame.inputText");
         _addBtn = ComponentFactory.Instance.creatComponentByStylename("CustomizedVipBuyFrame.addBtn");
         _delBtn = ComponentFactory.Instance.creatComponentByStylename("CustomizedVipBuyFrame.delBtn");
         _limitText = ComponentFactory.Instance.creatComponentByStylename("CustomizedVipBuyFrame.limitText");
         _sureBtn = ComponentFactory.Instance.creatComponentByStylename("CustomizedVipBuyFrame.sureBtn");
         addToContent(_bg);
         addToContent(_costItem);
         addToContent(_inputText);
         addToContent(_addBtn);
         addToContent(_delBtn);
         addToContent(_limitText);
         addToContent(_sureBtn);
         _inputText.text = buyNum + "";
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__frameResponse);
         _inputText.addEventListener("change",__inputChangeHandler);
         _addBtn.addEventListener("click",__addHandler);
         _delBtn.addEventListener("click",__deleteHandler);
         _sureBtn.addEventListener("click",__confirmHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         if(_inputText)
         {
            _inputText.removeEventListener("change",__inputChangeHandler);
         }
         if(_addBtn)
         {
            _addBtn.removeEventListener("click",__addHandler);
         }
         if(_delBtn)
         {
            _delBtn.removeEventListener("click",__deleteHandler);
         }
         if(_sureBtn)
         {
            _sureBtn.removeEventListener("click",__confirmHandler);
         }
      }
      
      private function __inputChangeHandler(param1:Event) : void
      {
         if(!data)
         {
            return;
         }
         var _loc2_:int = parseInt(_inputText.text);
         if(_loc2_ <= 0)
         {
            _inputText.text = "1";
         }
         if(_loc2_ >= data.leftCount)
         {
            _inputText.text = data.leftCount + "";
         }
         buyNum = parseInt(_inputText.text);
         updateBtnState();
      }
      
      private function __addHandler(param1:MouseEvent) : void
      {
         if(!data)
         {
            return;
         }
         if(buyNum >= data.leftCount)
         {
            return;
         }
         buyNum = buyNum + 1;
         updateBtnState();
      }
      
      private function __deleteHandler(param1:MouseEvent) : void
      {
         if(!data)
         {
            return;
         }
         if(buyNum <= 1)
         {
            return;
         }
         buyNum = buyNum - 1;
         updateBtnState();
      }
      
      private function updateBtnState() : void
      {
         totalPrice = data.price * buyNum;
         _inputText.text = buyNum + "";
         _costItem.firstText = totalPrice + "";
         _addBtn.enable = buyNum < data.leftCount;
         _delBtn.enable = buyNum > 1;
      }
      
      private function __confirmHandler(param1:MouseEvent) : void
      {
         if(!data)
         {
            return;
         }
         SoundManager.instance.play("022");
         var _loc2_:String = LanguageMgr.GetTranslation("CustomizedVip.buyBox.content",totalPrice,buyNum);
         LogicUtils.alert(_loc2_,"SIMPLE_ALERT",buySureHandler);
      }
      
      private function buySureHandler(param1:Boolean, param2:Boolean) : void
      {
         if(!param1)
         {
            return;
         }
         if(!LogicUtils.judgePointEnoughToShowPay(totalPrice,false))
         {
            return;
         }
         CustomizedVipManager.instance.sendCustomizedVipReq(2,data.type,buyNum,buyStr);
         dispose();
      }
      
      private function get buyStr() : String
      {
         var _loc1_:SimpleDictionary = null;
         var _loc3_:String = "";
         if(model.clientBoxDic[data.type])
         {
            _loc1_ = model.clientBoxDic[data.type];
            for(var _loc2_:String in _loc1_)
            {
               _loc3_ += _loc2_ + "," + _loc1_[_loc2_].tempId + "|";
            }
         }
         return _loc3_.substring(0,_loc3_.lastIndexOf("|"));
      }
      
      public function get data() : CustomizedVipBoxInfo
      {
         return _data;
      }
      
      public function set data(param1:CustomizedVipBoxInfo) : void
      {
         _data = param1;
         if(!data)
         {
            return;
         }
         _costItem.firstText = data.price + "";
         _limitText.text = LanguageMgr.GetTranslation("CustomizedVipRightItem.leftText.text",data.leftCount,data.maxCount);
         updateBtnState();
      }
      
      private function get model() : CustomizedVipModel
      {
         return CustomizedVipManager.instance.model;
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
      
      public function show(param1:ModuleFrameInfo = null) : void
      {
         LayerManager.Instance.addToLayer(this,3,true,true,1);
         titleText = LanguageMgr.GetTranslation("campaign.TrailShop.BuyBtnTxt");
         if(param1 && param1.frameData)
         {
            data = param1.frameData as CustomizedVipBoxInfo;
         }
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_costItem);
         _costItem = null;
         ObjectUtils.disposeObject(_inputText);
         _inputText = null;
         ObjectUtils.disposeObject(_addBtn);
         _addBtn = null;
         ObjectUtils.disposeObject(_delBtn);
         _delBtn = null;
         ObjectUtils.disposeObject(_limitText);
         _limitText = null;
         ObjectUtils.disposeObject(_sureBtn);
         _sureBtn = null;
         super.dispose();
      }
   }
}

