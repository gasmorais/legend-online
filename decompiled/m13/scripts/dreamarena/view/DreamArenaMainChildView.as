package dreamarena.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.utils.ObjectUtils;
   import dreamarena.item.DreamArenaChildSelectItem;
   import dreamarena.item.DreamArenaCommonSelectItemII;
   import flash.events.MouseEvent;
   import managers.DreamArenaManager;
   import mvc.module.dreamarena.DreamArenaModel;
   import utils.LogicUtils;
   import yishi.manager.TempleteManager;
   import yishi.utils.MsgMan;
   import yishi.view.component.TileContainer;
   
   public class DreamArenaMainChildView extends Component
   {
      
      private var _back:ScaleBitmapImage;
      
      private var _titleImage:MutipleImage;
      
      private var _childCon:TileContainer;
      
      private var _petHbox:HBox;
      
      private var _saveBtn:BaseButton;
      
      private var childList:Vector.<DreamArenaChildSelectItem>;
      
      private var petList:Vector.<DreamArenaCommonSelectItemII>;
      
      public function DreamArenaMainChildView()
      {
         super();
         initView();
         initListView();
         addEvent();
      }
      
      private function initView() : void
      {
         _back = ComponentFactory.Instance.creatComponentByStylename("DreamArenaChildView.back");
         _titleImage = ComponentFactory.Instance.creatComponentByStylename("DreamArenaChildView.titleImage");
         _childCon = ComponentFactory.Instance.creatCustomObject("DreamArenaMainChildView.childCon");
         _petHbox = ComponentFactory.Instance.creatComponentByStylename("DreamArenaChildView.petHbox");
         _saveBtn = ComponentFactory.Instance.creatComponentByStylename("DreamArenaChildView.saveBtn");
         addChild(_back);
         addChild(_titleImage);
         addChild(_childCon);
         addChild(_petHbox);
         addChild(_saveBtn);
      }
      
      private function initListView() : void
      {
         var _loc1_:DreamArenaChildSelectItem = null;
         var _loc4_:DreamArenaCommonSelectItemII = null;
         var _loc3_:int = 0;
         var _loc2_:Array = TempleteManager.instance.dreamArenaTempCate.getTemplateByType(3);
         var _loc5_:Array = TempleteManager.instance.dreamArenaTempCate.getTemplateByType(2);
         childList = new Vector.<DreamArenaChildSelectItem>();
         petList = new Vector.<DreamArenaCommonSelectItemII>();
         _loc3_ = 0;
         while(_loc3_ < _loc2_.length)
         {
            _loc1_ = new DreamArenaChildSelectItem(1,_loc3_ + 1);
            _loc1_.data = _loc2_[_loc3_];
            _childCon.appendItem(_loc1_);
            childList.push(_loc1_);
            _loc3_++;
         }
         _loc3_ = 0;
         while(_loc3_ < _loc5_.length)
         {
            _loc4_ = new DreamArenaCommonSelectItemII(2,_loc3_ + 1);
            _loc4_.data = _loc5_[_loc3_];
            _petHbox.addChild(_loc4_);
            petList.push(_loc4_);
            _loc3_++;
         }
         refreshSaveBtn();
      }
      
      private function addEvent() : void
      {
         _saveBtn.addEventListener("click",__saveChildHandler);
         MsgMan.addObserver("DREAM_ARENA_CLIENT_SELECT",this,__updateClientSelectHandler);
      }
      
      private function removeEvent() : void
      {
         if(_saveBtn)
         {
            _saveBtn.removeEventListener("click",__saveChildHandler);
         }
         MsgMan.removeObserver("DREAM_ARENA_CLIENT_SELECT",this,__updateClientSelectHandler);
      }
      
      private function __saveChildHandler(param1:MouseEvent) : void
      {
         var _loc3_:int = int(model.selfInfo.mainChildId);
         var _loc2_:int = int(model.selfInfo.mainChildPetId);
         if(model.clientSelectDic[3])
         {
            _loc3_ = int(model.clientSelectDic[3]);
         }
         if(model.clientSelectDic[32])
         {
            _loc2_ = int(model.clientSelectDic[32]);
         }
         DreamArenaManager.instance.sendChildSelect(7,_loc3_,_loc2_);
      }
      
      private function __updateClientSelectHandler(param1:String, param2:Object) : void
      {
         var _loc3_:DreamArenaChildSelectItem = null;
         var _loc4_:int = 0;
         var _loc5_:DreamArenaCommonSelectItemII = null;
         var _loc6_:int = param2 as int;
         if(_loc6_ == 3)
         {
            _loc4_ = 0;
            while(_loc4_ < childList.length)
            {
               _loc3_ = childList[_loc4_];
               _loc3_.refreshClientSelect();
               _loc4_++;
            }
         }
         else if(_loc6_ == 32)
         {
            _loc4_ = 0;
            while(_loc4_ < petList.length)
            {
               _loc5_ = petList[_loc4_];
               _loc5_.refreshClientSelect();
               _loc4_++;
            }
         }
         refreshSaveBtn();
      }
      
      public function refreshView() : void
      {
         var _loc1_:DreamArenaChildSelectItem = null;
         var _loc4_:DreamArenaCommonSelectItemII = null;
         var _loc3_:int = 0;
         var _loc2_:Array = TempleteManager.instance.dreamArenaTempCate.getTemplateByType(3);
         var _loc5_:Array = TempleteManager.instance.dreamArenaTempCate.getTemplateByType(2);
         _loc3_ = 0;
         while(_loc3_ < childList.length)
         {
            _loc1_ = childList[_loc3_];
            _loc1_.data = _loc2_[_loc3_];
            _loc3_++;
         }
         _loc3_ = 0;
         while(_loc3_ < _loc5_.length)
         {
            _loc4_ = petList[_loc3_];
            _loc4_.data = _loc5_[_loc3_];
            _loc3_++;
         }
         refreshSaveBtn();
      }
      
      private function refreshSaveBtn() : void
      {
         _saveBtn.enable = model.getMainChildChange();
      }
      
      private function get model() : DreamArenaModel
      {
         return DreamArenaManager.instance.model;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_back);
         _back = null;
         ObjectUtils.disposeObject(_titleImage);
         _titleImage = null;
         ObjectUtils.disposeObject(_childCon);
         _childCon = null;
         ObjectUtils.disposeObject(_petHbox);
         _petHbox = null;
         ObjectUtils.disposeObject(_saveBtn);
         _saveBtn = null;
         LogicUtils.disposeDisplayCollection(childList);
         childList = null;
         LogicUtils.disposeDisplayCollection(petList);
         petList = null;
         model.clientSelectDic.del(3);
         model.clientSelectDic.del(32);
         super.dispose();
      }
   }
}

