package dreamarena.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.utils.ObjectUtils;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import managers.DreamArenaManager;
   import mvc.module.dreamarena.DreamArenaModel;
   import mvc.module.dreamarena.DreamArenaSelectRoleInfo;
   import yishi.datas.templates.DreamArenaTempInfo;
   import yishi.utils.MsgMan;
   
   public class DreamArenaTalismanSelectView extends Component
   {
      
      private var _twoSelectBtn:TextButton;
      
      private var _fourSelectBtn:TextButton;
      
      private var data:DreamArenaTempInfo;
      
      public function DreamArenaTalismanSelectView()
      {
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         _twoSelectBtn = ComponentFactory.Instance.creatComponentByStylename("DreamArenaTalismanSelectView.twoSelectBtn");
         _fourSelectBtn = ComponentFactory.Instance.creatComponentByStylename("DreamArenaTalismanSelectView.fourSelectBtn");
         addChild(_twoSelectBtn);
         addChild(_fourSelectBtn);
         _twoSelectBtn.text = LanguageMgr.GetTranslation("dreamArena.selectBtn.towSkill");
         _fourSelectBtn.text = LanguageMgr.GetTranslation("dreamArena.selectBtn.fourSkill");
      }
      
      private function addEvent() : void
      {
         _twoSelectBtn.addEventListener("click",__selectBtnClickHandler);
         _fourSelectBtn.addEventListener("click",__selectBtnClickHandler);
      }
      
      private function removeEvent() : void
      {
         if(_twoSelectBtn)
         {
            _twoSelectBtn.removeEventListener("click",__selectBtnClickHandler);
         }
         if(_fourSelectBtn)
         {
            _fourSelectBtn.removeEventListener("click",__selectBtnClickHandler);
         }
      }
      
      private function __selectBtnClickHandler(param1:MouseEvent) : void
      {
         var _loc4_:int = 0;
         var _loc2_:Array = null;
         if(!data)
         {
            return;
         }
         if(param1.currentTarget is TextButton && param1.currentTarget.stylename == "DreamArenaTalismanSelectView.twoSelectBtn")
         {
            _loc4_ = 1;
         }
         else if(param1.currentTarget is TextButton && param1.currentTarget.stylename == "DreamArenaTalismanSelectView.fourSelectBtn")
         {
            _loc4_ = 2;
         }
         if(!model.clientSelectDic[24])
         {
            _loc2_ = [];
            _loc2_.push(data.TemplateId);
            _loc2_.push(_loc4_);
         }
         else
         {
            _loc2_ = model.clientSelectDic[24] as Array;
            if(_loc2_.indexOf(data.TemplateId) != -1)
            {
               _loc2_ = [];
               _loc2_.push(data.TemplateId);
               _loc2_.push(_loc4_);
            }
            else if(_loc2_.indexOf(_loc4_) != -1)
            {
               _loc2_ = [];
               _loc2_.push(data.TemplateId);
               _loc2_.push(_loc4_);
            }
            else
            {
               _loc2_.push(data.TemplateId);
               _loc2_.push(_loc4_);
            }
         }
         model.clientSelectDic.add(24,_loc2_);
         var _loc3_:int = 24;
         MsgMan.notifyObserver("DREAM_ARENA_CLIENT_SELECT",_loc3_);
         dispose();
      }
      
      public function show(param1:DreamArenaTempInfo) : void
      {
         var _loc3_:int = 0;
         data = param1;
         LayerManager.Instance.addToLayer(this,7);
         var _loc2_:Array = [];
         if(model.clientSelectDic[24])
         {
            _loc2_ = model.clientSelectDic[24] as Array;
            _loc3_ = int(model.selectJob);
         }
         else
         {
            _loc2_ = selectInfo.talismanSkillsAry;
            _loc3_ = int(selectInfo.selfSelectJob);
         }
         var _loc4_:int = _loc2_.indexOf(data.TemplateId);
         if(_loc3_ == 4 && _loc4_ != -1)
         {
            if(_loc2_[_loc4_ + 1] == 1)
            {
               _twoSelectBtn.enable = false;
               _fourSelectBtn.enable = true;
            }
            else if(_loc2_[_loc4_ + 1] == 2)
            {
               _twoSelectBtn.enable = true;
               _fourSelectBtn.enable = false;
            }
            else
            {
               _twoSelectBtn.enable = true;
               _fourSelectBtn.enable = true;
            }
         }
         else
         {
            _twoSelectBtn.enable = true;
            _fourSelectBtn.enable = true;
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
         ObjectUtils.disposeObject(_twoSelectBtn);
         _twoSelectBtn = null;
         ObjectUtils.disposeObject(_fourSelectBtn);
         _fourSelectBtn = null;
         if(parent)
         {
            parent.removeChild(this);
         }
         super.dispose();
      }
   }
}

