package dragontitan
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
   import manager.LanguageMgr;
   import managers.DragonTitanManager;
   import mvc.module.dragonTitan.DragonTitanModel;
   import yishi.datas.ConfigInfoManager;
   import yishi.datas.templates.SkillTempInfo;
   import yishi.manager.DragManager;
   import yishi.manager.GoodsManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.GameDrag;
   import yishi.utils.IconFactory;
   import yishi.utils.MsgMan;
   import yishi.utils.SimpleAlertHelper;
   import yishi.view.community.BaseIconView;
   import yishi.view.tips.MessageTipManager;
   
   public class DragonTitanSkillSlot extends Component
   {
      
      private var _skillBg1:Image;
      
      private var _orderBg:Image;
      
      private var _lockSkill:Image;
      
      private var _icon:BaseIconView;
      
      private var _orderNum:FilterFrameText;
      
      private var _isLock:Boolean = false;
      
      private var _data:SkillTempInfo;
      
      private var openSkillConfigArr:Array;
      
      public var index:int;
      
      public function DragonTitanSkillSlot(param1:int)
      {
         super();
         index = param1;
         openSkillConfigArr = ConfigInfoManager.instance.getTitanSkillItemCost();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _skillBg1 = ComponentFactory.Instance.creatComponentByStylename("dragontitan.skillBg1");
         _orderBg = ComponentFactory.Instance.creatComponentByStylename("dragontitan.orderBg");
         _lockSkill = ComponentFactory.Instance.creatComponentByStylename("dragontitan.lockSkill");
         _icon = ComponentFactory.Instance.creatCustomObject("dragontitan.DragonTitanSkillSlot.icon");
         _orderNum = ComponentFactory.Instance.creatComponentByStylename("DragonTitanSkillSlot.orderNum");
         addChild(_skillBg1);
         addChild(_icon);
         addChild(_lockSkill);
         addChild(_orderBg);
         addChild(_orderNum);
         _lockSkill.visible = false;
         _lockSkill.buttonMode = true;
         _orderNum.text = index + 1 + "";
         _orderNum.x = index + 1 >= 10 ? -6 : -2;
      }
      
      private function initEvent() : void
      {
         addEventListener("mouseDown",__clickHandler);
         _lockSkill.addEventListener("click",__openSkillHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("mouseDown",__clickHandler);
         if(_lockSkill)
         {
            _lockSkill.removeEventListener("click",__openSkillHandler);
         }
      }
      
      private function __openSkillHandler(param1:MouseEvent) : void
      {
         var _loc5_:Boolean = Boolean(model.getIsSkillGroupActive(model.skillGroupArr[model.comboxIndex]));
         if(!_loc5_)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("DragonTitanSkillSlot.open.noActive"));
            return;
         }
         var _loc4_:String = TempleteManager.instance.goodsTemplateCate.getTemplateByID(openSkillConfigArr[0]).TemplateName;
         SimpleAlertHelper.instance.data = [__openSkillItemHandler];
         var _loc2_:String = LanguageMgr.GetTranslation("public.confirm");
         var _loc3_:String = LanguageMgr.GetTranslation("public.cancel");
         var _loc6_:String = LanguageMgr.GetTranslation("public.prompt");
         var _loc7_:String = LanguageMgr.GetTranslation("DragonTitanSkillSlot.openSkillSlot.costAlert",openSkillConfigArr[1],_loc4_);
         SimpleAlertHelper.instance.popAlerFrame(_loc6_,_loc7_,_loc2_,_loc3_,true,false,false,2);
      }
      
      private function __openSkillItemHandler(param1:Boolean, param2:Boolean) : void
      {
         var _loc3_:int = 0;
         if(param1)
         {
            _loc3_ = int(GoodsManager.instance.getBagCountInPlayerAndStoneByTempId(openSkillConfigArr[0]));
            if(_loc3_ < openSkillConfigArr[1])
            {
               MessageTipManager.instance().show(LanguageMgr.GetTranslation("DragonTitanSkillSlot.open.noMaterialAlert"));
               return;
            }
            DragonTitanManager.instance.sendOpenSkillItem(model.comboxIndex);
         }
      }
      
      public function get isLock() : Boolean
      {
         return _isLock;
      }
      
      public function set isLock(param1:Boolean) : void
      {
         _isLock = param1;
         _lockSkill.visible = _isLock;
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
      
      public function get data() : *
      {
         return _data;
      }
      
      private function __clickHandler(param1:MouseEvent) : void
      {
         if(!_data)
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
         _loc2_.dropChecks = [DragonTitanSkillSlot,Stage];
      }
      
      private function getDragIconObj() : DisplayObject
      {
         var _loc1_:BitmapData = new BitmapData(_icon.iconWidth / _icon.scaleX,_icon.iconHeight / _icon.scaleY,true,0);
         _loc1_.draw(_icon);
         return new Bitmap(_loc1_);
      }
      
      private function onDragStop(param1:GameDrag) : void
      {
         var _loc2_:DragonTitanSkillSlot = null;
         var _loc3_:int = 0;
         if(param1.dropTarget != this)
         {
            param1.stopImmediatePropagation();
            if(param1.dropTarget is DragonTitanSkillSlot)
            {
               _loc2_ = param1.dropTarget as DragonTitanSkillSlot;
               _loc3_ = int(model.getTitanIdBySkillId(this.data.TemplateId));
               MsgMan.notifyObserver("DragonTitanEvent.TITAN_SET_SKILL",{
                  "titanId":_loc3_,
                  "index":_loc2_.index
               });
            }
            else
            {
               MsgMan.notifyObserver("DragonTitanEvent.TITAN_SET_SKILL",{
                  "titanId":0,
                  "index":this.index
               });
               this.data = null;
            }
         }
      }
      
      private function get model() : DragonTitanModel
      {
         return DragonTitanManager.instance.model;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         if(_skillBg1)
         {
            ObjectUtils.disposeObject(_skillBg1);
         }
         _skillBg1 = null;
         if(_orderBg)
         {
            ObjectUtils.disposeObject(_orderBg);
         }
         _orderBg = null;
         if(_lockSkill)
         {
            ObjectUtils.disposeObject(_lockSkill);
         }
         _lockSkill = null;
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
         super.dispose();
      }
   }
}

