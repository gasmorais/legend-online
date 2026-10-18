package loginactivity.view
{
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import funny.datas.FunnyBagData;
   import manager.LanguageMgr;
   import managers.FunnyManager;
   import yishi.datas.goods.GoodsInfo;
   import yishi.view.community.BaseItemView;
   
   public class LoginActiveItem extends Sprite implements Disposeable, IManualSize
   {
      
      private var _text:FilterFrameText;
      
      private var _hBox:HBox;
      
      private var _btn:IconButton;
      
      private var _receivedIcon:Image;
      
      private var _data:FunnyBagData;
      
      private var _index:int;
      
      public function LoginActiveItem()
      {
         super();
         initView();
      }
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,100,43);
      }
      
      private function initView() : void
      {
         _text = ComponentFactory.Instance.creatComponentByStylename("loginActive.Item.Txt");
         _hBox = ComponentFactory.Instance.creatComponentByStylename("loginActive.Item.Contain");
         _btn = ComponentFactory.Instance.creatComponentByStylename("loginActive.Item.Btn");
         _receivedIcon = ComponentFactory.Instance.creatComponentByStylename("loginActive.CountedTxt_2");
         addChild(_text);
         addChild(_hBox);
         addChild(_btn);
         addChild(_receivedIcon);
         _receivedIcon.mouseEnabled = _receivedIcon.mouseChildren = false;
         _btn.visible = false;
      }
      
      private function initEvent() : void
      {
         _btn.addEventListener("click",__clickHandler);
      }
      
      private function removeEvent() : void
      {
         _btn && _btn.removeEventListener("click",__clickHandler);
      }
      
      private function __clickHandler(param1:MouseEvent) : void
      {
         FunnyManager.instance.sendGetBag(2,_data.activeId,_data.id);
         param1.stopPropagation();
      }
      
      public function set data(param1:FunnyBagData) : void
      {
         var _loc4_:int = 0;
         var _loc2_:BaseItemView = null;
         var _loc5_:GoodsInfo = null;
         if(!param1)
         {
            return;
         }
         _data = param1;
         _loc4_ = 0;
         while(_loc4_ < _data.rewardList.length)
         {
            _loc2_ = ComponentFactory.Instance.creatCustomObject("countlogin.DropItem");
            _loc5_ = new GoodsInfo();
            _loc5_.templateId = _data.rewardList[_loc4_].temId;
            _loc5_.count = _data.rewardList[_loc4_].count;
            _loc5_.isBinds = _data.rewardList[_loc4_].isBind;
            _loc5_.strengthenGrade = _data.rewardList[_loc4_].strengthenGrade;
            _loc2_.data = _loc5_;
            _hBox.addChild(_loc2_);
            _loc4_++;
         }
         if(_data.status == 1)
         {
            _btn.visible = true;
            _btn.enable = true;
            _receivedIcon.visible = false;
         }
         else if(_data.status == 2)
         {
            _btn.visible = false;
            _receivedIcon.visible = true;
         }
         else if(_data.status == 3)
         {
            _btn.visible = true;
            _btn.enable = false;
            _receivedIcon.visible = false;
         }
         if(_btn.enable && Boolean(_btn.visible))
         {
            initEvent();
         }
         var _loc3_:String = LanguageMgr.GetTranslation("loginactivity.view.LoginActiveItem.loginText");
         var _loc6_:String = LanguageMgr.GetTranslation("countlogin.view.CountLoginItem.dayText");
         _index = _data.conditionList[0].value;
         _text.htmlText = _loc3_ + " <font color=\'#15c425\'>" + _index + "</font> " + _loc6_;
      }
      
      public function dispose() : void
      {
         removeEvent();
         if(_text)
         {
            _text.dispose();
         }
         _text = null;
         if(_btn)
         {
            _btn.dispose();
         }
         _btn = null;
         if(_receivedIcon)
         {
            _receivedIcon.dispose();
         }
         _receivedIcon = null;
         ObjectUtils.disposeAllChildren(_hBox);
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

