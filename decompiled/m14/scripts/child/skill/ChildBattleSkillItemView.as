package child.skill
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.display.Stage;
   import flash.events.MouseEvent;
   import managers.ChildManager;
   import mvc.module.children.ChildModel;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.datas.templates.SkillTempInfo;
   import yishi.manager.DragManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.GameDrag;
   import yishi.utils.IconFactory;
   import yishi.view.community.BaseIconView;
   
   public class ChildBattleSkillItemView extends Component
   {
      
      private var _data:SkillTempInfo;
      
      private var _index:int;
      
      private var _bg:ScaleFrameImage;
      
      private var _icon:BaseIconView;
      
      private var _lvBg:Bitmap;
      
      private var _lvTxt:FilterFrameText;
      
      private var showType:int;
      
      private var _buffIcon:Image;
      
      public function ChildBattleSkillItemView(param1:int)
      {
         super();
         showType = param1;
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatComponentByStylename("ChildBattleSkillItemView.bg");
         _icon = ComponentFactory.Instance.creatCustomObject("child.childBattleSkillItemView.icon");
         _lvBg = ComponentFactory.Instance.creatBitmap("asset.childSkillBattleSkillItem.lvBg");
         _lvTxt = ComponentFactory.Instance.creatComponentByStylename("Child.childBattleSkillItemLvTxt");
         addChild(_bg);
         addChild(_icon);
         addChild(_lvBg);
         addChild(_lvTxt);
         _lvTxt.text = "1";
         _bg.setFrame(showType);
         if(showType == 2)
         {
            _buffIcon = ComponentFactory.Instance.creatComponentByStylename("ChildBattleSkillItemView.skBuffFlg");
            addChild(_buffIcon);
            _buffIcon.visible = false;
            _bg.x = -20;
            _bg.y = -10;
         }
      }
      
      private function initEvent() : void
      {
         this.addEventListener("mouseDown",__clickHandler);
      }
      
      public function refreshView() : void
      {
      }
      
      public function set data(param1:SkillTempInfo) : void
      {
         _data = param1;
         if(_icon)
         {
            _icon.icon = null;
            _icon.tipData = null;
            if(!_data)
            {
               return;
            }
            _icon.icon = IconFactory.getTecIconByIcon(_data.Icons);
            _icon.tipData = _data;
         }
      }
      
      public function updateFmBuff(param1:int) : void
      {
         var _loc2_:SkillTempInfo = null;
         if(_buffIcon)
         {
            if(param1 > 0)
            {
               _loc2_ = TempleteManager.instance.getSkillById(param1);
               if(_loc2_)
               {
                  _buffIcon.visible = true;
                  _buffIcon.tipData = _loc2_;
               }
               else
               {
                  _buffIcon.visible = false;
               }
            }
            else
            {
               _buffIcon.visible = false;
            }
         }
      }
      
      public function get data() : *
      {
         return _data;
      }
      
      private function __clickHandler(param1:MouseEvent) : void
      {
         if(ChildManager.instance.curSelectChild == null)
         {
            return;
         }
         var _loc3_:DisplayObject = getDragIconObj();
         if(!_loc3_)
         {
            return;
         }
         var _loc2_:GameDrag = DragManager.getInstance().starDrag(this,{
            "icon":_loc3_,
            "type":"down"
         });
         _loc2_.onDrop = onDragStop;
         _loc2_.dropChecks = [ChildBattleSkillItemView,Stage];
      }
      
      private function getDragIconObj() : DisplayObject
      {
         var _loc1_:BitmapData = new BitmapData(_icon.iconWidth / _icon.scaleX,_icon.iconHeight / _icon.scaleY,true,0);
         _loc1_.draw(_icon);
         return new Bitmap(_loc1_);
      }
      
      public function set index(param1:int) : void
      {
         _index = param1;
         _lvTxt.text = _index + "";
      }
      
      public function get index() : int
      {
         return _index;
      }
      
      private function removeEvent() : void
      {
         this.removeEventListener("mouseDown",__clickHandler);
      }
      
      private function onDragStop(param1:GameDrag) : void
      {
         var _loc2_:ChildBattleSkillItemView = null;
         if(param1.dropTarget != this)
         {
            if(param1.dropTarget is ChildBattleSkillItemView)
            {
               _loc2_ = param1.dropTarget as ChildBattleSkillItemView;
               swapItem(this,_loc2_);
               param1.stopImmediatePropagation();
               NotificationManager.instance.sendNotification("REFRESHCHILDBATTLESKILL");
            }
            else
            {
               data = null;
               refreshView();
               NotificationManager.instance.sendNotification("REFRESHCHILDBATTLESKILL");
               param1.stopImmediatePropagation();
            }
         }
         param1.stopImmediatePropagation();
      }
      
      private function swapItem(param1:ChildBattleSkillItemView, param2:ChildBattleSkillItemView) : void
      {
         var _loc3_:SkillTempInfo = null;
         _loc3_ = param1.data;
         param1.data = param2.data;
         param2.data = _loc3_;
      }
      
      private function get model() : ChildModel
      {
         return ChildManager.instance.model;
      }
      
      private function get playerInfo() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_icon);
         _icon = null;
         ObjectUtils.disposeObject(_lvBg);
         _lvBg = null;
         ObjectUtils.disposeObject(_lvTxt);
         _lvTxt = null;
         ObjectUtils.disposeObject(_buffIcon);
         _buffIcon = null;
         super.dispose();
      }
   }
}

