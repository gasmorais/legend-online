package child.skill
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import managers.ChildManager;
   import mvc.module.children.ChildModel;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.datas.templates.SkillTempInfo;
   import yishi.manager.DragManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.PlayerManager;
   import yishi.utils.GameDrag;
   import yishi.utils.IconFactory;
   import yishi.view.community.BaseIconView;
   
   public class ChildSkillItemView extends Component
   {
      
      private var _item:BaseIconView;
      
      private var _lvBg:Bitmap;
      
      private var _lvTxt:FilterFrameText;
      
      private var _data:SkillTempInfo;
      
      private var _isLearn:Boolean;
      
      private var _maxGrade:int;
      
      public function ChildSkillItemView()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _item = ComponentFactory.Instance.creatCustomObject("child.childSkillItemView.icon");
         _lvBg = ComponentFactory.Instance.creatBitmap("asset.childSkill.skillItemLvBg");
         _lvTxt = ComponentFactory.Instance.creatComponentByStylename("Child.childSkillItemLvTxt");
         addChild(_item);
         addChild(_lvBg);
         addChild(_lvTxt);
      }
      
      private function initEvent() : void
      {
         _item.addEventListener("mouseDown",__clickHandler);
      }
      
      private function __clickHandler(param1:MouseEvent) : void
      {
         if(!_data || !isLearn || _data.UseWay == 2)
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
         _loc2_.dropChecks = [ChildBattleSkillItemView,Frame,stage];
      }
      
      private function getDragIconObj() : DisplayObject
      {
         if(_item.iconWidth == 0)
         {
            return new Bitmap(new BitmapData(30,30,true,285212672));
         }
         var _loc1_:BitmapData = new BitmapData(_item.iconWidth / _item.scaleX,_item.iconHeight / _item.scaleY,true,0);
         _loc1_.draw(_item);
         var _loc3_:Bitmap = new Bitmap(_loc1_);
         var _loc2_:Sprite = new Sprite();
         _loc2_.addChild(_loc3_);
         return _loc2_;
      }
      
      private function onDragStop(param1:GameDrag) : void
      {
         var _loc2_:ChildBattleSkillItemView = null;
         if(param1.dropTarget != this)
         {
            if(param1.dropTarget is ChildBattleSkillItemView)
            {
               _loc2_ = param1.dropTarget as ChildBattleSkillItemView;
               _loc2_.data = _data;
               _loc2_.refreshView();
               NotificationManager.instance.sendNotification("REFRESHCHILDBATTLESKILL");
            }
            else
            {
               param1.stopImmediatePropagation();
            }
         }
      }
      
      private function removeEvent() : void
      {
         if(_item)
         {
            _item.removeEventListener("mouseDown",__clickHandler);
         }
      }
      
      public function set data(param1:SkillTempInfo) : void
      {
         if(!param1 && _item)
         {
            return;
         }
         _data = param1;
         _item.icon = IconFactory.getTecIconByIcon(data.Icons);
         _item.tipData = param1;
         if(_isLearn)
         {
            _lvTxt.text = getCurGradeByGrade(param1.Grades) + "/" + getMaxGradeByGrade(param1.Grades);
         }
         else
         {
            _lvTxt.text = "0/" + getMaxGradeByGrade(param1.Grades);
         }
      }
      
      public function setLvlText(param1:String) : void
      {
         _lvTxt.text = param1;
      }
      
      public function get data() : *
      {
         return _data;
      }
      
      public function get isLearn() : Boolean
      {
         return _isLearn;
      }
      
      public function set isLearn(param1:Boolean) : void
      {
         _isLearn = param1;
      }
      
      private function getCurGradeByGrade(param1:uint) : int
      {
         var _loc2_:* = 0;
         if(param1 > 5)
         {
            _loc2_ = uint(param1 - 5);
         }
         else
         {
            _loc2_ = param1;
         }
         return _loc2_;
      }
      
      private function getMaxGradeByGrade(param1:uint) : int
      {
         var _loc2_:* = 0;
         if(param1 > 5)
         {
            _loc2_ = uint(_maxGrade - 5);
         }
         else
         {
            _loc2_ = 5;
         }
         return _loc2_;
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
         ObjectUtils.disposeObject(_item);
         _item = null;
         ObjectUtils.disposeObject(_lvBg);
         _lvBg = null;
         ObjectUtils.disposeObject(_lvTxt);
         _lvTxt = null;
         super.dispose();
      }
      
      public function set maxGrade(param1:int) : void
      {
         _maxGrade = param1;
      }
   }
}

