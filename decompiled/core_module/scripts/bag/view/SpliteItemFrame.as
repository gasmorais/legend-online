package bag.view
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.events.Event;
   import flash.events.FocusEvent;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.datas.templates.GoodsTemplateInfo;
   import yishi.keyboard.KeyBoardRegister;
   import yishi.manager.ArmyManager;
   import yishi.manager.GoodsManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.ResourceManager;
   import yishi.manager.TempleteManager;
   import yishi.view.community.BaseItemView;
   
   public class SpliteItemFrame extends Frame
   {
      
      protected var _item:BaseItemView;
      
      private var _confirmBtn:TextButton;
      
      private var _alertText:Bitmap;
      
      protected var _numberText:FilterFrameText;
      
      private var _inputBack:Bitmap;
      
      protected var _goodsInfo:GoodsInfo;
      
      protected var isItem:Boolean = true;
      
      public function SpliteItemFrame()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         titleText = LanguageMgr.GetTranslation("bag.view.SpliteItemFrame.title");
         _inputBack = ComponentFactory.Instance.creatBitmap("asset.core.SpliteInputBack");
         addToContent(_inputBack);
         _confirmBtn = ComponentFactory.Instance.creatComponentByStylename("core.ConfirmBtn");
         _confirmBtn.text = LanguageMgr.GetTranslation("public.confirm");
         addToContent(_confirmBtn);
         _alertText = ComponentFactory.Instance.creatBitmap("asset.core.InputAlertTextStyle");
         addToContent(_alertText);
         _numberText = ComponentFactory.Instance.creatComponentByStylename("core.InputTextStyle");
         _numberText.selectable = true;
         _numberText.text = "1";
         addToContent(_numberText);
      }
      
      private function initEvent() : void
      {
         addEventListener("response",__frameResponse);
         _confirmBtn.addEventListener("click",__confirmHandler);
         _numberText.addEventListener("keyDown",__keydownHandler);
         _numberText.addEventListener("change",__textChangHandler);
         _numberText.addEventListener("focusIn",__inHandler);
      }
      
      protected function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         _confirmBtn.removeEventListener("click",__confirmHandler);
         _numberText.removeEventListener("keyDown",__keydownHandler);
         _numberText.removeEventListener("change",__textChangHandler);
         _numberText.removeEventListener("focusIn",__inHandler);
      }
      
      private function __inHandler(param1:FocusEvent) : void
      {
         _numberText.setSelection(0,_numberText.text.length);
      }
      
      protected function __textChangHandler(param1:Event) : void
      {
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc3_:GoodsTemplateInfo = null;
         var _loc4_:int = 0;
         var _loc2_:int = int(_numberText.text);
         if(isItem)
         {
            _loc5_ = _item.data.count;
            if(_item.data.templateInfo.SonType == 311)
            {
               switch(_item.data.templateInfo.Property2)
               {
                  case -800:
                     _loc6_ = thane.gloryPoint / _item.data.templateInfo.Property3;
                     break;
                  case -700:
                     _loc6_ = playerInfo.strategy / _item.data.templateInfo.Property3;
                     break;
                  case -600:
                     _loc6_ = ResourceManager.instance.waterCrystal.count / _item.data.templateInfo.Property3;
                     break;
                  case -500:
                     _loc6_ = playerInfo.giftToken / _item.data.templateInfo.Property3;
                     break;
                  case -400:
                     _loc6_ = playerInfo.point / _item.data.templateInfo.Property3;
                     break;
                  case -300:
                     _loc6_ = playerInfo.strategy / _item.data.templateInfo.Property3;
                     break;
                  case -200:
                     _loc6_ = playerInfo.mineral / _item.data.templateInfo.Property3;
                     break;
                  case -100:
                     _loc6_ = ResourceManager.instance.gold.count / _item.data.templateInfo.Property3;
                     break;
                  default:
                     _loc6_ = GoodsManager.instance.getGoodsNumByTempId(_item.data.templateInfo.Property2) / _item.data.templateInfo.Property3;
               }
               _loc5_ = Math.min(_loc6_,_item.data.count);
            }
            if(_loc2_ > _loc5_)
            {
               _loc2_ = _loc5_;
               _numberText.text = _loc2_.toString();
            }
            else if(_loc2_ == 0)
            {
               _numberText.text = "";
            }
            else
            {
               _numberText.text = _loc2_.toString();
            }
         }
         else
         {
            _loc5_ = GoodsManager.instance.getGoodsNumByTempId(_goodsInfo.templateId);
            _loc3_ = TempleteManager.instance.goodsTemplateCate.getTemplateByID(_goodsInfo.templateId);
            if(_loc3_.SonType == 226)
            {
               _loc4_ = _goodsInfo.count;
            }
            _numberText.text = Math.min(_loc2_,_loc5_,_loc4_).toString();
         }
      }
      
      private function __keydownHandler(param1:KeyboardEvent) : void
      {
         if(param1.keyCode == 13)
         {
            __confirmHandler(null);
         }
         param1.stopPropagation();
      }
      
      protected function __confirmHandler(param1:MouseEvent) : void
      {
         starDrag();
         dispose();
      }
      
      private function starDrag() : void
      {
         if(!_numberText || !_item)
         {
            return;
         }
         var _loc1_:int = int(_numberText.text);
         if(_loc1_ > 0 && _item.data)
         {
            NotificationManager.instance.sendNotification("DRAG_ITEM_BagNotic",[_item,_loc1_]);
         }
      }
      
      public function set data(param1:*) : void
      {
         if(param1 is BaseItemView)
         {
            _item = param1;
            _goodsInfo = null;
         }
         else if(param1 is GoodsInfo)
         {
            _goodsInfo = param1;
            _item = null;
         }
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,3,true,true,2);
         KeyBoardRegister.instance.keyEnable = false;
         _numberText.setFocus();
      }
      
      private function __frameResponse(param1:FrameEvent) : void
      {
         switch(param1.responseCode)
         {
            case 0:
            case 1:
               dispose();
               break;
            case 2:
               __confirmHandler(null);
         }
      }
      
      private function get thane() : ThaneInfo
      {
         return ArmyManager.instance.thane;
      }
      
      private function get playerInfo() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
      }
      
      override public function dispose() : void
      {
         KeyBoardRegister.instance.keyEnable = true;
         removeEvent();
         ObjectUtils.disposeObject(_confirmBtn);
         _confirmBtn = null;
         ObjectUtils.disposeObject(_alertText);
         _alertText = null;
         ObjectUtils.disposeObject(_numberText);
         _numberText = null;
         ObjectUtils.disposeObject(_inputBack);
         _inputBack = null;
         _item = null;
         super.dispose();
      }
   }
}

