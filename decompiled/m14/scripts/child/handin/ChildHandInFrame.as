package child.handin
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.utils.ObjectUtils;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import manager.LanguageMgr;
   import managers.ChildManager;
   import mvc.ModuleFrameInfo;
   import mvc.module.children.ChildModel;
   import mvc.module.children.ChildSender;
   import ui.tasktracebar.view.ChildRemoveAlert;
   import utils.LogicUtils;
   import yishi.datas.goods.GoodsInfo;
   import yishi.manager.GoodsManager;
   import yishi.utils.MsgMan;
   import yishi.view.tips.MessageTipManager;
   
   public class ChildHandInFrame extends Frame
   {
      
      private var _bg:Scale9CornerImage;
      
      private var _vBox:VBox;
      
      private var _confirmBtn:IconButton;
      
      private var _list:Vector.<ChildHandInItem>;
      
      private var _selfHeight:int;
      
      public function ChildHandInFrame()
      {
         super();
         initView();
         initEvent();
      }
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,400,570);
      }
      
      override public function get groups() : Array
      {
         return ["BAG_GROUP","MAIN_TOOLS_GROUP"];
      }
      
      private function initView() : void
      {
         titleText = LanguageMgr.GetTranslation("child.handin.ChildHandInFrame.titleTxt");
         _bg = ComponentFactory.Instance.creatComponentByStylename("ChildHandInFrame.bg");
         _vBox = ComponentFactory.Instance.creatComponentByStylename("ChildHandInFrame.vBox");
         _confirmBtn = ComponentFactory.Instance.creatComponentByStylename("ChildHandInFrame.confirmBtn");
         _list = new Vector.<ChildHandInItem>();
         addToContent(_bg);
         addToContent(_vBox);
         addToContent(_confirmBtn);
         initChildrenView();
      }
      
      private function initChildrenView() : void
      {
         var _loc2_:int = 0;
         var _loc1_:ChildHandInItem = null;
         if(_vBox)
         {
            _vBox.disposeAllChildren();
            _list.length = 0;
            _loc2_ = 0;
            while(_loc2_ < model.childList.length)
            {
               if(model.childList[_loc2_].fightUserId <= 0)
               {
                  _loc1_ = new ChildHandInItem();
                  _loc1_.data = model.childList[_loc2_];
                  _vBox.addChild(_loc1_);
                  _list.push(_loc1_);
               }
               _loc2_++;
            }
            if(_list.length <= 0)
            {
               MessageTipManager.instance().show(LanguageMgr.GetTranslation("child.handin.ChildHandInFrame.noChildToHandin"));
               dispose();
               return;
            }
         }
         if(_bg)
         {
            _bg.height = _list.length * 95 + 20;
         }
         if(_confirmBtn)
         {
            _confirmBtn.y = _bg.height + 10;
            _selfHeight = _confirmBtn.y + 140;
            height = _selfHeight;
            _confirmBtn.enable = false;
         }
      }
      
      override public function set height(param1:Number) : void
      {
         if(_selfHeight > 0)
         {
            super.height = _selfHeight;
         }
         else
         {
            super.height = param1;
         }
      }
      
      private function unInitView() : void
      {
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_vBox);
         _vBox = null;
         ObjectUtils.disposeObject(_confirmBtn);
         _confirmBtn = null;
         LogicUtils.disposeDisplayCollection(_list);
         _list = null;
      }
      
      private function initEvent() : void
      {
         if(_confirmBtn)
         {
            _confirmBtn.addEventListener("click",__confirmBtnHandler);
         }
         addEventListener("response",__responseHandler);
         MsgMan.addObserver("ChildEvent.HAND_IN_CHANGE",this,__selectedHandler);
         MsgMan.addObserver("ChildEvent.HAND_IN",this,__handInfoHandler);
         MsgMan.addObserver("ChildEvent.ENTER_CHANGE",this,__enterWarChangeHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__responseHandler);
         if(_confirmBtn)
         {
            _confirmBtn.removeEventListener("click",__confirmBtnHandler);
         }
         MsgMan.removeObserver("ChildEvent.HAND_IN_CHANGE",this,__selectedHandler);
         MsgMan.removeObserver("ChildEvent.HAND_IN",this,__handInfoHandler);
         MsgMan.removeObserver("ChildEvent.ENTER_CHANGE",this,__enterWarChangeHandler);
      }
      
      private function __responseHandler(param1:FrameEvent) : void
      {
         switch(int(param1.responseCode))
         {
            case 0:
            case 1:
               dispose();
         }
      }
      
      private function __enterWarChangeHandler(param1:String, param2:Object) : void
      {
         initChildrenView();
      }
      
      private function __handInfoHandler(param1:String, param2:Object) : void
      {
         dispose();
      }
      
      private function __selectedHandler(param1:String, param2:Object) : void
      {
         var _loc3_:int = 0;
         _confirmBtn.enable = false;
         _loc3_ = 0;
         while(_loc3_ < _list.length)
         {
            if(_list[_loc3_].selected)
            {
               _confirmBtn.enable = true;
               break;
            }
            _loc3_++;
         }
      }
      
      private function __confirmBtnHandler(param1:MouseEvent) : void
      {
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:GoodsInfo = null;
         var _loc2_:String = "";
         var _loc4_:Boolean = false;
         var _loc5_:String = "";
         _loc6_ = 0;
         while(_loc6_ < _list.length)
         {
            if(_loc4_)
            {
               break;
            }
            if(_list[_loc6_].selected)
            {
               _loc7_ = 0;
               while(_loc7_ < 8)
               {
                  _loc8_ = GoodsManager.instance.getItemByPOB(_loc7_,_list[_loc6_].data.childId,30);
                  if(_loc8_)
                  {
                     _loc4_ = true;
                     break;
                  }
                  _loc7_++;
               }
               if(_loc2_ == "")
               {
                  _loc2_ += _list[_loc6_].data.childId;
                  _loc5_ += _list[_loc6_].data.name;
               }
               else
               {
                  _loc2_ = _loc2_ + "," + _list[_loc6_].data.childId;
                  _loc5_ = _loc5_ + "," + _list[_loc6_].data.name;
               }
            }
            _loc6_++;
         }
         if(_loc4_)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("child.handin.ChildHandInFrame.hasEquip"));
            return;
         }
         var _loc3_:ChildRemoveAlert = ComponentFactory.Instance.creatComponentByStylename("core.childRemoveAlert");
         _loc3_.backFun = removeChildHandler;
         _loc3_.param = _loc2_;
         _loc3_.showStr = _loc5_;
         LayerManager.Instance.addToLayer(_loc3_,3,true,true,1);
      }
      
      private function removeChildHandler(param1:String) : void
      {
         var _loc2_:String = null;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:GoodsInfo = null;
         var _loc3_:Array = param1.split(",");
         _loc4_ = 0;
         loop0:
         while(_loc4_ < _loc3_.length)
         {
            if(model.getChildById(int(_loc3_[_loc4_])) == null)
            {
               _loc2_ = LanguageMgr.GetTranslation("child.handin.ChildHandInFrame.noThisChild");
               MessageTipManager.instance().show(_loc2_);
               dispose();
               return;
            }
            if(model.getChildById(int(_loc3_[_loc4_])).fightUserId > 0)
            {
               _loc2_ = LanguageMgr.GetTranslation("child.handin.ChildHandInFrame.fightingChild");
               MessageTipManager.instance().show(_loc2_);
               return;
            }
            _loc5_ = 0;
            while(true)
            {
               if(_loc5_ >= 8)
               {
                  _loc4_++;
                  continue loop0;
               }
               _loc6_ = GoodsManager.instance.getItemByPOB(_loc5_,int(_loc3_[_loc4_]),30);
               if(_loc6_)
               {
                  break;
               }
               _loc5_++;
            }
            _loc2_ = LanguageMgr.GetTranslation("child.handin.ChildHandInFrame.hasEquip");
            MessageTipManager.instance().show(_loc2_);
            return;
         }
         ChildSender.removeChild(param1);
         _loc2_ = LanguageMgr.GetTranslation("child.handin.ChildHandInFrame.waiting");
         MessageTipManager.instance().show(_loc2_);
         dispose();
      }
      
      private function get model() : ChildModel
      {
         return ChildManager.instance.model;
      }
      
      public function show(param1:ModuleFrameInfo = null) : void
      {
         LayerManager.Instance.addToLayer(this,3,true,true);
      }
      
      override public function dispose() : void
      {
         removeEvent();
         unInitView();
         super.dispose();
      }
   }
}

