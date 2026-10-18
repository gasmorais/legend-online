package remotepet.views
{
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.ScaleLeftRightImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.text.GradientText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.events.MouseEvent;
   import mvc.module.remotepet.RemotePetOrderInfo;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.manager.ArmyManager;
   import yishi.view.community.PlayerMenu;
   
   public class RemotePetOrderItemView extends Component
   {
      
      private var _sort:FilterFrameText;
      
      private var _vipIcon:Bitmap;
      
      private var _name:FilterFrameText;
      
      private var _vipnameTxt:GradientText;
      
      private var _index:FilterFrameText;
      
      private var _fight:FilterFrameText;
      
      private var _data:RemotePetOrderInfo;
      
      private var _line:ScaleLeftRightImage;
      
      private var _menu:PlayerMenu;
      
      public function RemotePetOrderItemView()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         _line = ComponentFactory.Instance.creatComponentByStylename("remotepet.RemotePetOrderItemView.Line");
         _sort = ComponentFactory.Instance.creatComponentByStylename("remotepet.RemotePetOrderItemView.sortText");
         _vipIcon = ComponentFactory.Instance.creatBitmap("asset.core.simpleVIPIcon");
         _name = ComponentFactory.Instance.creatComponentByStylename("remotepet.RemotePetOrderItemView.nameText");
         _vipnameTxt = ComponentFactory.Instance.creatComponentByStylename("remotepet.RemotePetOrderItemView.vipText");
         _index = ComponentFactory.Instance.creatComponentByStylename("remotepet.RemotePetOrderItemView.indexText");
         _fight = ComponentFactory.Instance.creatComponentByStylename("remotepet.RemotePetOrderItemView.fightText");
         addChild(_line);
         addChild(_sort);
         _sort.setFrame(1);
         addChild(_vipIcon);
         _vipIcon.x = 48;
         _vipIcon.y = 12;
         addChild(_name);
         _name.setFrame(1);
         addChild(_vipnameTxt);
         addChild(_index);
         _index.setFrame(1);
         addChild(_fight);
         _fight.setFrame(1);
         clean();
      }
      
      private function initEvent() : void
      {
         addEventListener("click",__clickHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("click",__clickHandler);
      }
      
      private function __clickHandler(param1:MouseEvent) : void
      {
         if(!_data)
         {
            return;
         }
         _menu = new PlayerMenu();
         var _loc2_:ThaneInfo = new ThaneInfo();
         _loc2_.userId = _data.userId;
         _loc2_.nickName = _data.nickName;
         _loc2_.consortiaName = _data.consortiaName;
         _loc2_.grades = _data.grades;
         _loc2_.fightingCapacity = _data.fightingCapacity;
         _menu.setData(_loc2_);
         _menu.x = StageReferance.stage.mouseX;
         _menu.y = StageReferance.stage.mouseY;
         LayerManager.Instance.addToLayer(_menu,7);
      }
      
      public function set data(param1:RemotePetOrderInfo) : void
      {
         _data = param1;
         if(!param1)
         {
            clean();
            return;
         }
         initEvent();
         _sort.text = _data.order + "";
         _name.text = _data.nickName;
         _vipnameTxt.text = _data.nickName;
         _index.text = _data.index + "";
         _fight.text = _data.fight + "";
         _vipIcon.x = (210 - _vipnameTxt.textWidth) / 2 - _vipIcon.width;
         _sort.visible = true;
         if(_data.isVip)
         {
            _vipIcon.visible = true;
            _vipnameTxt.visible = true;
            _name.visible = false;
         }
         else
         {
            _vipIcon.visible = false;
            _vipnameTxt.visible = false;
            _name.visible = true;
         }
         if(thane.userId == _data.userId)
         {
            _vipIcon.visible = false;
            _vipnameTxt.visible = false;
            _name.visible = true;
            _sort.setFrame(2);
            _name.setFrame(2);
            _index.setFrame(2);
            _fight.setFrame(2);
         }
         else
         {
            _sort.setFrame(1);
            _name.setFrame(1);
            _index.setFrame(1);
            _fight.setFrame(1);
         }
      }
      
      private function get thane() : ThaneInfo
      {
         return ArmyManager.instance.thane;
      }
      
      public function clean() : void
      {
         _sort.text = "";
         _name.text = "";
         _vipnameTxt.text = "";
         _index.text = "";
         _sort.setFrame(1);
         _name.setFrame(1);
         _index.setFrame(1);
         _fight.setFrame(1);
         _vipIcon.visible = false;
         _vipnameTxt.visible = false;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_sort);
         _sort = null;
         ObjectUtils.disposeObject(_vipIcon);
         _vipIcon = null;
         ObjectUtils.disposeObject(_name);
         _name = null;
         ObjectUtils.disposeObject(_vipnameTxt);
         _vipnameTxt = null;
         ObjectUtils.disposeObject(_index);
         _index = null;
         ObjectUtils.disposeObject(_fight);
         _fight = null;
         ObjectUtils.disposeObject(_menu);
         _menu = null;
         _data = null;
         super.dispose();
      }
   }
}

