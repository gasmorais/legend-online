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
   import managers.MarryManager;
   import mvc.ModuleFrameInfo;
   import mvc.module.children.ChildData;
   import mvc.module.children.ChildModel;
   import mvc.module.marry.MarryModel;
   import mvc.module.marry.MarrySender;
   import utils.LogicUtils;
   import yishi.datas.goods.GoodsInfo;
   import yishi.manager.GoodsManager;
   import yishi.utils.MsgMan;
   import yishi.utils.SimpleAlertHelper;
   import yishi.view.tips.MessageTipManager;
   
   public class ChildDivideFrame extends Frame
   {
      
      private var _bg:Scale9CornerImage;
      
      private var _vBox:VBox;
      
      private var _confirmBtn:IconButton;
      
      private var _list:Vector.<ChildHandInItem>;
      
      private var _selfHeight:int;
      
      private var _type:int;
      
      private var _ids:Array;
      
      public function ChildDivideFrame()
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
         titleText = LanguageMgr.GetTranslation("child.handin.ChildDivideFrame.title");
         _bg = ComponentFactory.Instance.creatComponentByStylename("ChildHandInFrame.bg");
         _vBox = ComponentFactory.Instance.creatComponentByStylename("ChildHandInFrame.vBox");
         _confirmBtn = ComponentFactory.Instance.creatComponentByStylename("ChildHandInFrame.confirmBtn");
         _list = new Vector.<ChildHandInItem>();
         _ids = [];
         addToContent(_bg);
         addToContent(_vBox);
         addToContent(_confirmBtn);
         initChildrenView();
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
         _ids = null;
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
            while(_loc2_ < childModel.childList.length)
            {
               _loc1_ = new ChildHandInItem();
               _loc1_.data = childModel.childList[_loc2_];
               _vBox.addChild(_loc1_);
               _list.push(_loc1_);
               _loc2_++;
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
      
      private function initEvent() : void
      {
         if(_confirmBtn)
         {
            _confirmBtn.addEventListener("click",__confirmBtnHandler);
         }
         addEventListener("response",__responseHandler);
         MsgMan.addObserver("ChildEvent.HAND_IN_CHANGE",this,__selectedHandler);
         MsgMan.addObserver("ChildEvent.HAND_IN",this,__handInfoHandler);
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
      
      private function __handInfoHandler(param1:String, param2:Object) : void
      {
         dispose();
      }
      
      private function __selectedHandler(param1:String, param2:Object) : void
      {
         var _loc3_:int = 0;
         _ids.length = 0;
         _loc3_ = 0;
         while(_loc3_ < _list.length)
         {
            if(_list[_loc3_].selected)
            {
               _ids.push(_list[_loc3_].data.childId);
            }
            _loc3_++;
         }
      }
      
      private function __confirmBtnHandler(param1:MouseEvent) : void
      {
         var _loc6_:int = 0;
         if(_ids.length > 2)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("child.handin.ChildDivideFrame.countLimit"));
            return;
         }
         var _loc2_:String = "";
         var _loc13_:String = "";
         var _loc9_:String = "";
         if(_ids.length > 0)
         {
            _loc2_ = _ids.join(",");
         }
         else
         {
            _loc13_ = "--";
         }
         _loc6_ = 0;
         while(_loc6_ < _ids.length)
         {
            _loc13_ = _loc13_ + "[" + childModel.getChildById(_ids[_loc6_]).name + "]";
            _loc6_++;
         }
         var _loc5_:String = "--";
         var _loc7_:String = "--";
         var _loc3_:Array = [];
         for each(var _loc4_:ChildData in childModel.childList)
         {
            if(_ids.indexOf(_loc4_.childId) < 0)
            {
               _loc3_.push(_loc4_);
            }
         }
         var _loc8_:String = LanguageMgr.GetTranslation("child.handin.ChildDivideFrame.alertContent1",_loc13_,_loc7_,_loc5_);
         if(_loc3_.length > 2)
         {
            _loc3_.sortOn("fightValue",2 | 0x10);
            _loc6_ = 2;
            while(_loc6_ < _loc3_.length)
            {
               _loc9_ = _loc9_ + "[" + _loc3_[_loc6_].name + "]";
               _loc6_++;
            }
            _loc8_ = LanguageMgr.GetTranslation("child.handin.ChildDivideFrame.alertContent2",_loc13_,_loc9_,_loc7_,_loc5_);
         }
         SimpleAlertHelper.instance.data = [divideCall,_loc2_];
         var _loc10_:String = LanguageMgr.GetTranslation("public.confirm");
         var _loc11_:String = LanguageMgr.GetTranslation("public.cancel");
         var _loc12_:String = LanguageMgr.GetTranslation("public.prompt");
         SimpleAlertHelper.instance.popAlerFrame(_loc12_,_loc8_,_loc10_,_loc11_,false,true,true);
         dispose();
      }
      
      private function divideCall(param1:Boolean, param2:Boolean, param3:String) : void
      {
         var _loc4_:Array = null;
         var _loc5_:Boolean = false;
         var _loc6_:int = 0;
         if(param1 && Boolean(marryModel.isMarry))
         {
            _loc4_ = GoodsManager.instance.getGeneralBagChildEquipList();
            _loc5_ = false;
            for each(var _loc7_:GoodsInfo in _loc4_)
            {
               if(_loc5_)
               {
                  break;
               }
               _loc6_ = 1;
               while(_loc6_ <= 4)
               {
                  if(_loc7_["join" + _loc6_] > 0)
                  {
                     _loc5_ = true;
                     break;
                  }
                  _loc6_++;
               }
            }
            if(_loc5_)
            {
               MessageTipManager.instance().show(LanguageMgr.GetTranslation("child.handin.ChildDivideFrame.hasJewel"));
               return;
            }
            if(_type == 92)
            {
               MarrySender.divorce(1,param3,false);
            }
            else if(_type == 93)
            {
               MarrySender.divorce(1,param3,true);
            }
         }
      }
      
      private function get childModel() : ChildModel
      {
         return ChildManager.instance.model;
      }
      
      private function get marryModel() : MarryModel
      {
         return MarryManager.instance.model;
      }
      
      public function show(param1:ModuleFrameInfo = null) : void
      {
         _type = int(param1.frameData.type);
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

