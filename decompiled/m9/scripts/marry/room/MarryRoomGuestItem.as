package marry.room
{
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.SelectedButton;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.image.ScaleLeftRightImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.text.GradientText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.events.MouseEvent;
   import mvc.module.marry.MarryGuestInfo;
   import yishi.datas.consant.JobType;
   
   public class MarryRoomGuestItem extends SelectedButton
   {
      
      private var _itemBg:Scale9CornerImage;
      
      private var _vipIcon:Bitmap;
      
      private var _name:FilterFrameText;
      
      private var _vipnameTxt:GradientText;
      
      private var _work:FilterFrameText;
      
      private var _data:MarryGuestInfo;
      
      private var _menu:MarryGuestTips;
      
      private var _line:ScaleLeftRightImage;
      
      private var _sex:ScaleFrameImage;
      
      public function MarryRoomGuestItem()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         _itemBg = ComponentFactory.Instance.creatComponentByStylename("MarryRoomGuestItem.ItemBg");
         _line = ComponentFactory.Instance.creatComponentByStylename("MarryRoomGuestItem.Line");
         _vipIcon = ComponentFactory.Instance.creatBitmap("asset.core.simpleVIPIcon");
         _name = ComponentFactory.Instance.creatComponentByStylename("MarryRoomGuestItem.nameText");
         _vipnameTxt = ComponentFactory.Instance.creatComponentByStylename("MarryRoomGuestItem.vipText");
         _work = ComponentFactory.Instance.creatComponentByStylename("MarryRoomGuestItem.workText");
         _sex = ComponentFactory.Instance.creatComponentByStylename("MarryRoomGuestItem.sexImage");
         addChild(_itemBg);
         _itemBg.visible = false;
         addChild(_line);
         addChild(_vipIcon);
         _vipIcon.x = 48;
         _vipIcon.y = 5;
         addChild(_name);
         addChild(_vipnameTxt);
         addChild(_work);
         addChild(_sex);
         refreshView();
      }
      
      public function set data(param1:MarryGuestInfo) : void
      {
         _data = param1;
         refreshView();
      }
      
      private function refreshView() : void
      {
         if(!_data)
         {
            setVisible(false);
            return;
         }
         setVisible(true);
         _name.text = _data.nickNameA;
         _vipnameTxt.text = _data.nickNameA;
         _work.text = JobType.getJobName(_data.jobA);
         _sex.setFrame(sexNum(_data.jobA));
         _vipIcon.x = (220 - _vipnameTxt.textWidth) / 2 - _vipIcon.width;
         if(_data.property2 == 1)
         {
            _vipIcon.visible = true;
            _vipnameTxt.visible = true;
            _name.visible = false;
         }
         else
         {
            _data.property2 == 0;
         }
         _vipIcon.visible = false;
         _vipnameTxt.visible = false;
         _name.visible = true;
      }
      
      public function setVisible(param1:Boolean) : void
      {
         if(_itemBg)
         {
            _itemBg.visible = false;
         }
         if(_vipIcon)
         {
            _vipIcon.visible = param1;
         }
         if(_name)
         {
            _name.visible = param1;
         }
         if(_vipnameTxt)
         {
            _vipnameTxt.visible = param1;
         }
         if(_work)
         {
            _work.visible = param1;
         }
         if(_sex)
         {
            _sex.visible = param1;
         }
         enable = param1;
      }
      
      private function sexNum(param1:int) : int
      {
         var _loc2_:int = 1;
         if(param1 == 1 || param1 == 2 || param1 == 3)
         {
            _loc2_ = 1;
         }
         else if(param1 == 4 || param1 == 5 || param1 == 6)
         {
            _loc2_ = 2;
         }
         return _loc2_;
      }
      
      override protected function addEvent() : void
      {
         super.addEvent();
         addEventListener("click",__clickHandler);
         addEventListener("rollOver",__onItemOver);
         addEventListener("rollOut",__onItemOut);
      }
      
      override protected function removeEvent() : void
      {
         super.removeEvent();
         removeEventListener("click",__clickHandler);
         removeEventListener("rollOver",__onItemOver);
         removeEventListener("rollOut",__onItemOut);
      }
      
      private function __onItemOver(param1:MouseEvent) : void
      {
         if(_data == null)
         {
            return;
         }
         _itemBg.visible = true;
      }
      
      private function __onItemOut(param1:MouseEvent) : void
      {
         if(_data == null)
         {
            return;
         }
         _itemBg.visible = false;
      }
      
      override public function set selected(param1:Boolean) : void
      {
         super.selected = param1;
         if(_data)
         {
            if(_itemBg)
            {
               _itemBg.visible = param1;
            }
         }
         else if(_itemBg)
         {
            _itemBg.visible = false;
         }
      }
      
      private function __clickHandler(param1:MouseEvent) : void
      {
         selected = true;
         if(!_data)
         {
            return;
         }
         _menu = new MarryGuestTips(_data);
         _menu.x = StageReferance.stage.mouseX;
         _menu.y = StageReferance.stage.mouseY;
         LayerManager.Instance.addToLayer(_menu,7);
      }
      
      override public function dispose() : void
      {
         removeEvent();
         _data = null;
         if(_name)
         {
            _name.dispose();
         }
         _name = null;
         if(_vipnameTxt)
         {
            _vipnameTxt.dispose();
         }
         _vipnameTxt = null;
         if(_work)
         {
            _work.dispose();
         }
         _work = null;
         if(_menu)
         {
            _menu.dispose();
         }
         _menu = null;
         if(_line)
         {
            _line.dispose();
         }
         _line = null;
         if(_sex)
         {
            _sex.dispose();
         }
         _sex = null;
         if(_itemBg)
         {
            _itemBg.dispose();
         }
         _itemBg = null;
         ObjectUtils.disposeObject(_vipIcon);
         _vipIcon = null;
         if(parent)
         {
            parent.removeChild(this);
         }
         super.dispose();
      }
   }
}

