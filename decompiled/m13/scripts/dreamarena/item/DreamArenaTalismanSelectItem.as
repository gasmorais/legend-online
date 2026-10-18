package dreamarena.item
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.utils.ObjectUtils;
   import dreamarena.view.DreamArenaTalismanSelectView;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import manager.LanguageMgr;
   import managers.DreamArenaManager;
   import mvc.module.dreamarena.DreamArenaModel;
   import mvc.module.dreamarena.DreamArenaSelectRoleInfo;
   import yishi.datas.templates.DreamArenaTempInfo;
   import yishi.utils.IconFactory;
   import yishi.view.community.BaseIconView;
   
   public class DreamArenaTalismanSelectItem extends Component
   {
      
      private var _icon:BaseIconView;
      
      private var _selectBg:Image;
      
      private var _selectBtn:TextButton;
      
      private var btnSelectView:DreamArenaTalismanSelectView;
      
      public var index:int;
      
      private var _data:DreamArenaTempInfo;
      
      public function DreamArenaTalismanSelectItem(param1:int)
      {
         super();
         index = param1;
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         _icon = ComponentFactory.Instance.creatCustomObject("DreamArena.DreamArenaTalismanSelectItem.icon");
         _selectBg = ComponentFactory.Instance.creatComponentByStylename("DreamArena.DreamArenaCommonSelectItem.selectBg");
         _selectBtn = ComponentFactory.Instance.creatComponentByStylename("DreamArena.DreamArenaCommonSelectItem.selectBtn");
         addChild(_icon);
         addChild(_selectBg);
         addChild(_selectBtn);
         _selectBg.mouseEnabled = false;
      }
      
      private function addEvent() : void
      {
         _selectBtn.addEventListener("click",_selectBtnClickHandler);
      }
      
      private function removeEvent() : void
      {
         if(_selectBtn)
         {
            _selectBtn.removeEventListener("click",_selectBtnClickHandler);
         }
      }
      
      private function _selectBtnClickHandler(param1:MouseEvent) : void
      {
         var _loc2_:Point = null;
         if(!data)
         {
            return;
         }
         if(!btnSelectView)
         {
            btnSelectView = new DreamArenaTalismanSelectView();
            btnSelectView.show(data);
            btnSelectView.addEventListener("dispose",__disposeSelectView);
            _loc2_ = new Point(_selectBtn.displayWidth / 2,0);
            _loc2_ = _selectBtn.localToGlobal(_loc2_);
            btnSelectView.x = _loc2_.x - 30;
            btnSelectView.y = _loc2_.y + 25;
         }
      }
      
      private function __disposeSelectView(param1:Event) : void
      {
         if(btnSelectView)
         {
            btnSelectView.removeEventListener("dispose",__disposeSelectView);
         }
         btnSelectView = null;
      }
      
      public function get data() : DreamArenaTempInfo
      {
         return _data;
      }
      
      public function set data(param1:DreamArenaTempInfo) : void
      {
         var _loc2_:int = 0;
         var _loc3_:Boolean = false;
         _data = param1;
         if(data)
         {
            _icon.icon = IconFactory.getGoodsIconByTID(data.TypeTemplateId);
            _icon.tipData = data;
            _loc2_ = int(selectInfo.talismanSkillsAry.indexOf(data.TemplateId));
            _loc3_ = selectInfo.selfSelectJob == 4 && _loc2_ != -1;
            _selectBg.visible = _loc3_;
            if(_loc3_)
            {
               if(selectInfo.talismanSkillsAry[_loc2_ + 1] == 1)
               {
                  _selectBtn.text = LanguageMgr.GetTranslation("dreamArena.selectBtn.towSkill");
               }
               else if(selectInfo.talismanSkillsAry[_loc2_ + 1] == 2)
               {
                  _selectBtn.text = LanguageMgr.GetTranslation("dreamArena.selectBtn.fourSkill");
               }
            }
            else
            {
               _selectBtn.text = LanguageMgr.GetTranslation("dreamArena.selectBtn.selectText");
            }
         }
         else
         {
            _icon.icon = null;
            _icon.tipData = null;
            _selectBg.visible = false;
         }
      }
      
      public function refreshClientSelect() : void
      {
         var _loc3_:Boolean = false;
         var _loc1_:Array = null;
         var _loc2_:int = 0;
         if(!data)
         {
            return;
         }
         if(!model.clientSelectDic[24])
         {
            _loc3_ = false;
         }
         else
         {
            _loc1_ = model.clientSelectDic[24] as Array;
            _loc2_ = _loc1_.indexOf(data.TemplateId);
            _loc3_ = model.selectJob == 4 && _loc2_ != -1;
         }
         _selectBg.visible = _loc3_;
         if(_loc3_)
         {
            if(_loc1_[_loc2_ + 1] == 1)
            {
               _selectBtn.text = LanguageMgr.GetTranslation("dreamArena.selectBtn.towSkill");
            }
            else if(_loc1_[_loc2_ + 1] == 2)
            {
               _selectBtn.text = LanguageMgr.GetTranslation("dreamArena.selectBtn.fourSkill");
            }
         }
         else
         {
            _selectBtn.text = LanguageMgr.GetTranslation("dreamArena.selectBtn.selectText");
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
         ObjectUtils.disposeObject(_icon);
         _icon = null;
         ObjectUtils.disposeObject(_selectBg);
         _selectBg = null;
         ObjectUtils.disposeObject(_selectBtn);
         _selectBtn = null;
         ObjectUtils.disposeObject(btnSelectView);
         btnSelectView = null;
         super.dispose();
      }
   }
}

