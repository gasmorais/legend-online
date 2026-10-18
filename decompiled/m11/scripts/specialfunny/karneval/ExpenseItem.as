package specialfunny.karneval
{
   import chat.view.ChatItemMenu;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.text.GradientText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import funny.datas.KarnevalInfo;
   
   public class ExpenseItem extends Sprite implements Disposeable
   {
      
      private var _vipIcon:Image;
      
      private var _vipName:GradientText;
      
      private var _name:FilterFrameText;
      
      private var _expenseTxt:FilterFrameText;
      
      private var _emptyImg:Bitmap;
      
      private var _pointImg:Image;
      
      private var _data:KarnevalInfo;
      
      private var _menu:ChatItemMenu;
      
      public function ExpenseItem()
      {
         super();
         inieView();
      }
      
      private function inieView() : void
      {
         _vipIcon = ComponentFactory.Instance.creatComponentByStylename("ExpenseItem.vipIcon");
         _vipName = ComponentFactory.Instance.creatComponentByStylename("ExpenseItem.vipName");
         _name = ComponentFactory.Instance.creatComponentByStylename("ExpenseItem.name");
         _expenseTxt = ComponentFactory.Instance.creatComponentByStylename("ExpenseItem.expenseTxt");
         _emptyImg = ComponentFactory.Instance.creatBitmap("asset.onlinereward.KarnevaEmptyImg");
         _pointImg = ComponentFactory.Instance.creatComponentByStylename("ExpenseItem.pointImg");
         addChild(_vipIcon);
         addChild(_name);
         addChild(_vipName);
         addChild(_expenseTxt);
         addChild(_emptyImg);
         addChild(_pointImg);
         _vipName.buttonMode = true;
         _emptyImg.visible = false;
      }
      
      public function set data(param1:KarnevalInfo) : void
      {
         _data = param1;
         if(_data == null)
         {
            _emptyImg.visible = true;
            _vipIcon.visible = false;
            _vipName.visible = false;
            _name.visible = false;
            _expenseTxt.visible = false;
            _pointImg.visible = false;
         }
         else
         {
            _emptyImg.visible = false;
            _vipIcon.visible = _data.isVip;
            _vipName.visible = true;
            _vipName.alpha = _data.isVip ? 1 : 0;
            _name.visible = !_data.isVip;
            _expenseTxt.visible = true;
            _pointImg.visible = true;
            _vipName.text = _data.nickName;
            _name.text = _data.nickName;
            _expenseTxt.text = _data.point + "";
            initEvent();
         }
      }
      
      private function initEvent() : void
      {
         _vipName.addEventListener("click",__clickHandler);
      }
      
      private function removeEvent() : void
      {
         if(_vipName)
         {
            _vipName.removeEventListener("click",__clickHandler);
         }
      }
      
      private function __clickHandler(param1:MouseEvent) : void
      {
         if(_data)
         {
            showUseMenu(StageReferance.stage.mouseX,StageReferance.stage.mouseY,_data.nickName,_data.userId);
         }
      }
      
      private function showUseMenu(param1:int, param2:int, param3:String, param4:int) : void
      {
         if(_menu)
         {
            _menu.dispose();
         }
         _menu = null;
         _menu = new ChatItemMenu(param3,param4,false);
         LayerManager.Instance.addToLayer(_menu,7);
         _menu.x = param1;
         _menu.y = param2 - _menu.height - 5;
         if(_menu.y < 0)
         {
            _menu.y = 0;
         }
      }
      
      public function dispose() : void
      {
         removeEvent();
         if(_vipIcon)
         {
            _vipIcon.dispose();
         }
         _vipIcon = null;
         if(_vipName)
         {
            _vipName.dispose();
         }
         _vipName = null;
         if(_name)
         {
            _name.dispose();
         }
         _name = null;
         if(_expenseTxt)
         {
            _expenseTxt.dispose();
         }
         _expenseTxt = null;
         ObjectUtils.disposeObject(_emptyImg);
         _emptyImg = null;
         if(_pointImg)
         {
            _pointImg.dispose();
         }
         _pointImg = null;
         if(_menu)
         {
            _menu.dispose();
         }
         _menu = null;
         _data = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

