package secretary.item
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.SelectedButton;
   import com.pickgliss.ui.controls.SelectedCheckButton;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import managers.SecretaryManager;
   import mvc.module.secretary.SecretaryData;
   import mvc.module.secretary.SecretaryItemData;
   
   public class SecretaryCompentItem extends Sprite
   {
      
      public var _bg:Bitmap;
      
      public var _title:FilterFrameText;
      
      public var _desc:FilterFrameText;
      
      private var _usebindPoint:SelectedCheckButton;
      
      private var _select:SelectedButton;
      
      public var _moneyNum:FilterFrameText;
      
      public var _moneyIcon:ScaleFrameImage;
      
      public var _goldNum:FilterFrameText;
      
      public var _goldIcon:ScaleFrameImage;
      
      public var _money:FilterFrameText;
      
      public var _moneyBg:Bitmap;
      
      private var _notJoinActPromptTxt:FilterFrameText;
      
      private var _data:SecretaryItemData;
      
      public function SecretaryCompentItem()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatBitmap("asset.secrearytary.bg1");
         _title = ComponentFactory.Instance.creatComponentByStylename("ui.secretaryItem.titleText");
         _desc = ComponentFactory.Instance.creatComponentByStylename("ui.secretaryItem.descText");
         _usebindPoint = ComponentFactory.Instance.creatComponentByStylename("secretaryItem.UseBindPointBtn");
         _usebindPoint.text = LanguageMgr.GetTranslation("secretary.LittleSecretaryFrameTips5");
         _select = ComponentFactory.Instance.creatComponentByStylename("secretaryItem.RefreshShopSelectButton");
         _moneyNum = ComponentFactory.Instance.creatComponentByStylename("SecretaryItem.moneyNumtext");
         _moneyIcon = ComponentFactory.Instance.creatComponentByStylename("secretary.view.moneyImg");
         _goldNum = ComponentFactory.Instance.creatComponentByStylename("SecretaryItem.moneyNumtext");
         _goldIcon = ComponentFactory.Instance.creatComponentByStylename("secretary.view.moneyImg");
         _money = ComponentFactory.Instance.creatComponentByStylename("SecretaryItem.moneytext");
         _money.text = LanguageMgr.GetTranslation("secretary.LittleSecretaryFrameTips4");
         _moneyBg = ComponentFactory.Instance.creatBitmap("asset.core.NormalPriceBg");
         _moneyBg.width = 145;
         _moneyBg.x = 1;
         _moneyBg.y = 75;
         addChild(_bg);
         addChild(_title);
         addChild(_desc);
         addChild(_usebindPoint);
         _usebindPoint.selected = true;
         addChild(_moneyBg);
         addChild(_moneyNum);
         addChild(_select);
         addChild(_moneyIcon);
         addChild(_money);
         _notJoinActPromptTxt = ComponentFactory.Instance.creatComponentByStylename("ecretaryItem.notJoinActPromptTxt");
         _notJoinActPromptTxt.text = LanguageMgr.GetTranslation("yishi.view.frame.TodayNotAlertFrame.notJoinActPromptTxt");
         addChild(_notJoinActPromptTxt);
         _select.selected = true;
      }
      
      public function set usebindPointTxt(param1:String) : void
      {
         if(_usebindPoint)
         {
            _usebindPoint.text = param1;
         }
      }
      
      private function initEvent() : void
      {
         _usebindPoint.addEventListener("click",__useBindPointHandler);
         _select.addEventListener("click",__pointSelectedHandler);
      }
      
      private function __pointSelectedHandler(param1:MouseEvent) : void
      {
         var _loc3_:int = 0;
         var _loc2_:Boolean = false;
         _loc3_ = 0;
         while(_loc3_ < model.allItemDatas.length)
         {
            if(model.allItemDatas[_loc3_].type == _data.type)
            {
               _loc2_ = Boolean(model.allItemDatas[_loc3_].state);
               model.allItemDatas[_loc3_].state = !_loc2_;
               _select.selected = model.allItemDatas[_loc3_].state;
               return;
            }
            _loc3_++;
         }
      }
      
      private function __useBindPointHandler(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         SoundManager.instance.play("008");
         _loc2_ = 0;
         while(_loc2_ < model.allItemDatas.length)
         {
            if(model.allItemDatas[_loc2_].type == _data.type)
            {
               _usebindPoint.selected = !model.allItemDatas[_loc2_].moneyState;
               model.allItemDatas[_loc2_].moneyState = !model.allItemDatas[_loc2_].moneyState;
               return;
            }
            _loc2_++;
         }
      }
      
      private function get model() : SecretaryData
      {
         return SecretaryManager.instance.model;
      }
      
      private function removeEvent() : void
      {
         if(_usebindPoint)
         {
            _usebindPoint.removeEventListener("click",__useBindPointHandler);
         }
         _select.removeEventListener("click",__pointSelectedHandler);
      }
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_title);
         _title = null;
         ObjectUtils.disposeObject(_desc);
         _desc = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
      
      public function set data(param1:SecretaryItemData) : void
      {
         _data = param1;
         _title.text = _data.title;
         _desc.htmlText = _data.des;
         _select.selected = _data.state;
         _usebindPoint.selected = _data.moneyState;
         _money.visible = _moneyNum.visible = _moneyIcon.visible = _moneyBg.visible = _data.moneyNum > 0 || _data.goldNum > 0;
         _notJoinActPromptTxt.visible = _usebindPoint.visible = _data.moneyType >= 1;
         if(_data.moneyNum > 0 || _data.goldNum > 0)
         {
            if(_data.moneyType == 1)
            {
               _moneyIcon.setFrame(1);
               _moneyNum.text = _data.moneyNum + "";
               _moneyNum.textColor = 9830143;
            }
            else if(_data.moneyType == 0)
            {
               _moneyNum.text = _data.goldNum + "";
               _moneyNum.textColor = 16763392;
               _moneyIcon.setFrame(2);
            }
            else
            {
               addChild(_goldIcon);
               addChild(_goldNum);
               _moneyIcon.setFrame(1);
               _moneyNum.text = _data.moneyNum + "";
               _moneyNum.textColor = 9830143;
               _goldNum.x = _moneyIcon.x + 75;
               _goldIcon.x = _moneyIcon.x + 50;
               _goldNum.text = _data.goldNum + "";
               _goldNum.textColor = 16763392;
               _goldIcon.setFrame(2);
            }
         }
      }
      
      public function get data() : SecretaryItemData
      {
         return _data;
      }
      
      public function refreshState() : void
      {
      }
   }
}

