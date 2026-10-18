package dreamarena.item
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.display.Stage;
   import flash.events.MouseEvent;
   import managers.DreamArenaManager;
   import mvc.module.dreamarena.DreamArenaModel;
   import mvc.module.dreamarena.DreamArenaSelectRoleInfo;
   import yishi.datas.templates.SkillTempInfo;
   import yishi.manager.DragManager;
   import yishi.utils.GameDrag;
   import yishi.utils.IconFactory;
   import yishi.utils.MsgMan;
   import yishi.view.community.BaseIconView;
   
   public class DreamArenaTitanSkillItem extends Component
   {
      
      private var _skillBg:Image;
      
      private var _orderBg:Image;
      
      private var _icon:BaseIconView;
      
      private var _orderNum:FilterFrameText;
      
      private var _equipedImage:Image;
      
      private var canDrop:Boolean = true;
      
      private var _data:SkillTempInfo;
      
      public var index:int;
      
      public var type:int;
      
      public function DreamArenaTitanSkillItem(param1:int, param2:int)
      {
         super();
         type = param1;
         index = param2;
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _skillBg = ComponentFactory.Instance.creatComponentByStylename("DreamArenaTitanSkillItem.skillBg");
         _orderBg = ComponentFactory.Instance.creatComponentByStylename("DreamArenaTitanSkillItem.orderBg");
         _icon = ComponentFactory.Instance.creatCustomObject("DreamArenaTitanSkillItem.skillIcon");
         _orderNum = ComponentFactory.Instance.creatComponentByStylename("DreamArenaTitanSkillItem.orderNum");
         _equipedImage = ComponentFactory.Instance.creatComponentByStylename("DreamArenaTitanSkillItem.equipedImage");
         addChild(_skillBg);
         addChild(_icon);
         addChild(_orderBg);
         addChild(_orderNum);
         addChild(_equipedImage);
         if(type == 1)
         {
            _orderNum.text = index + 1 + "";
            _orderNum.x = index + 1 >= 10 ? -6 : -2;
            _equipedImage.visible = false;
         }
         else
         {
            _orderNum.text = "";
            _orderBg.visible = false;
            _equipedImage.visible = false;
         }
      }
      
      private function initEvent() : void
      {
         addEventListener("mouseDown",__clickHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("mouseDown",__clickHandler);
      }
      
      public function set data(param1:SkillTempInfo) : void
      {
         _data = param1;
         if(data)
         {
            _icon.icon = IconFactory.getTecIconByIcon(_data.Icons);
            _icon.tipData = _data;
            _equipedImage.visible = type == 2 && selectInfo.titanSkillAry.indexOf(data.TemplateId + "") != -1;
         }
         else
         {
            _icon.icon = null;
            _icon.tipData = null;
            _equipedImage.visible = false;
         }
         canDrop = !_equipedImage.visible;
      }
      
      public function refreshClientSelect() : void
      {
         var _loc2_:Boolean = false;
         var _loc1_:Array = null;
         if(!data)
         {
            return;
         }
         if(!model.clientSelectDic[21])
         {
            _loc2_ = false;
         }
         else
         {
            _loc1_ = model.clientSelectDic[21] as Array;
            _loc2_ = _loc1_.indexOf(data.TemplateId) != -1;
         }
         _equipedImage.visible = type == 2 && _loc2_;
         canDrop = !_equipedImage.visible;
      }
      
      public function get data() : SkillTempInfo
      {
         return _data;
      }
      
      private function __clickHandler(param1:MouseEvent) : void
      {
         if(!_data || !canDrop)
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
         _loc2_.dropChecks = [DreamArenaTitanSkillItem,Stage];
      }
      
      private function getDragIconObj() : DisplayObject
      {
         var _loc1_:BitmapData = new BitmapData(_icon.iconWidth / _icon.scaleX,_icon.iconHeight / _icon.scaleY,true,0);
         _loc1_.draw(_icon);
         return new Bitmap(_loc1_);
      }
      
      private function onDragStop(param1:GameDrag) : void
      {
         var _loc2_:DreamArenaTitanSkillItem = null;
         if(param1.dropTarget != this)
         {
            param1.stopImmediatePropagation();
            if(type == 1)
            {
               if(param1.dropTarget is DreamArenaTitanSkillItem)
               {
                  _loc2_ = param1.dropTarget as DreamArenaTitanSkillItem;
                  if(_loc2_.type == 1)
                  {
                     MsgMan.notifyObserver("TITAN_SET_SKILL",{
                        "dragItem":this,
                        "dropItem":_loc2_
                     });
                  }
                  else
                  {
                     this.data = null;
                  }
               }
               else
               {
                  this.data = null;
               }
            }
            else if(param1.dropTarget is DreamArenaTitanSkillItem)
            {
               _loc2_ = param1.dropTarget as DreamArenaTitanSkillItem;
               if(_loc2_.type == 1)
               {
                  _loc2_.data = this.data;
               }
            }
            MsgMan.notifyObserver("TITAN_CLIENT_SKILL_UPDATE");
         }
      }
      
      private function get selectInfo() : DreamArenaSelectRoleInfo
      {
         return model.selfInfo;
      }
      
      private function get model() : DreamArenaModel
      {
         return DreamArenaManager.instance.model;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         if(_skillBg)
         {
            ObjectUtils.disposeObject(_skillBg);
         }
         _skillBg = null;
         if(_orderBg)
         {
            ObjectUtils.disposeObject(_orderBg);
         }
         _orderBg = null;
         if(_icon)
         {
            ObjectUtils.disposeObject(_icon);
         }
         _icon = null;
         if(_orderNum)
         {
            ObjectUtils.disposeObject(_orderNum);
         }
         _orderNum = null;
         if(_orderNum)
         {
            ObjectUtils.disposeObject(_equipedImage);
         }
         _equipedImage = null;
         super.dispose();
      }
   }
}

