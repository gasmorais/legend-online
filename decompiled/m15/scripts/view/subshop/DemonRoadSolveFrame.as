package view.subshop
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import com.road.yishi.proto.demonroad.DemonRoadRewardMsg;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import managers.IncreasinglyRoadManager;
   import yishi.datas.ComponentGroupType;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.templates.ResolveTemplateInfo;
   import yishi.keyboard.KeyBoardRegister;
   import yishi.manager.AvengerManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.MsgMan;
   import yishi.utils.SimpleAlertHelper;
   import yishi.view.community.BaseItemView;
   
   public class DemonRoadSolveFrame extends Frame
   {
      
      private var _sloveNumTxt:FilterFrameText;
      
      private var _addBtn:BaseButton;
      
      private var _deleteBtn:BaseButton;
      
      private var _bg:MutipleImage;
      
      private var _icon:BaseItemView;
      
      private var _img:Image;
      
      private var _btn:IconButton;
      
      private var _sloveNum:int = 0;
      
      private var _sp:Sprite;
      
      private var _getTxt:FilterFrameText;
      
      private var _gInfo:GoodsInfo = new GoodsInfo();
      
      private const GOODS_ID:int = 6930001;
      
      private var _limit:int;
      
      private var rInfo:ResolveTemplateInfo;
      
      public function DemonRoadSolveFrame()
      {
         super();
         initView();
         initEvent();
         refreshView();
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatComponentByStylename("ui.demonroadshop.solveback");
         _sloveNumTxt = ComponentFactory.Instance.creatComponentByStylename("quickbuy.BuyNumTextStyle");
         _addBtn = ComponentFactory.Instance.creatComponentByStylename("quickbuy.AddButton");
         _deleteBtn = ComponentFactory.Instance.creatComponentByStylename("quickbuy.DeleteButton");
         _icon = ComponentFactory.Instance.creatCustomObject("demonroad.soloveBaseItemView");
         _btn = ComponentFactory.Instance.creatComponentByStylename("demonroad.solveBtn");
         _img = ComponentFactory.Instance.creatComponentByStylename("demonroad.solveInputBg");
         _sp = ComponentFactory.Instance.creatCustomObject("demonroad.solveContainer");
         _getTxt = ComponentFactory.Instance.creatComponentByStylename("demonroadexchange.countTxt");
         addToContent(_bg);
         addToContent(_sp);
         addToContent(_icon);
         addToContent(_getTxt);
         addToContent(_btn);
         _sp.addChild(_img);
         _sp.addChild(_sloveNumTxt);
         _sp.addChild(_addBtn);
         _sp.addChild(_deleteBtn);
         rInfo = TempleteManager.instance.resolveTemplateCate.getTemplateByTypeAndTempId(2,6930001);
      }
      
      private function refreshView() : void
      {
         _limit = 0;
         if(AvengerManager.instance.model.armorBagDic[6930001])
         {
            _limit = AvengerManager.instance.model.armorBagDic[6930001].count;
         }
         _gInfo.templateId = 6930001;
         _gInfo.count = _limit;
         _icon.data = _gInfo;
         sloveNumChangeHandler();
      }
      
      private function initEvent() : void
      {
         addEventListener("response",__frameResponse);
         if(_addBtn)
         {
            _addBtn.addEventListener("click",__addHandler);
         }
         if(_deleteBtn)
         {
            _deleteBtn.addEventListener("click",__deleteHandler);
         }
         if(_sloveNumTxt)
         {
            _sloveNumTxt.addEventListener("change",__sloveNumChange);
         }
         if(_btn)
         {
            _btn.addEventListener("click",_sloveClickHandler);
         }
         MsgMan.addObserver("DEVIL_ARMOR_BAG_UPDATE",this,__updateHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         if(_addBtn)
         {
            _addBtn.removeEventListener("click",__addHandler);
         }
         if(_deleteBtn)
         {
            _deleteBtn.removeEventListener("click",__deleteHandler);
         }
         if(_sloveNumTxt)
         {
            _sloveNumTxt.removeEventListener("change",__sloveNumChange);
         }
         if(_btn)
         {
            _btn.removeEventListener("click",_sloveClickHandler);
         }
         MsgMan.removeObserver("DEVIL_ARMOR_BAG_UPDATE",this,__updateHandler);
      }
      
      private function __updateHandler(param1:String, param2:Object = null) : void
      {
         refreshView();
      }
      
      private function __frameResponse(param1:FrameEvent) : void
      {
         switch(int(param1.responseCode))
         {
            case 0:
               dispose();
               break;
            case 1:
               dispose();
         }
      }
      
      private function _sloveClickHandler(param1:MouseEvent) : void
      {
         var _loc2_:String = LanguageMgr.GetTranslation("demonroad.shop.exchangeConfirm",_sloveNum);
         SimpleAlertHelper.instance.data = [confirmChoose,_sloveNum];
         var _loc3_:String = LanguageMgr.GetTranslation("public.confirm");
         var _loc4_:String = LanguageMgr.GetTranslation("public.cancel");
         var _loc5_:String = LanguageMgr.GetTranslation("public.prompt");
         SimpleAlertHelper.instance.popAlerFrame(_loc5_,_loc2_,_loc3_,_loc4_,true,true);
      }
      
      private function confirmChoose(param1:Boolean, param2:Boolean, param3:int) : void
      {
         var _loc4_:Array = null;
         var _loc5_:DemonRoadRewardMsg = null;
         if(param1)
         {
            _loc4_ = [];
            _loc5_ = new DemonRoadRewardMsg();
            _loc5_.itemTempId = 6930001;
            _loc5_.count = param3;
            _loc4_.push(_loc5_);
            IncreasinglyRoadManager.instance.resolveGoods(_loc4_);
         }
      }
      
      private function __sloveNumChange(param1:Event) : void
      {
         _sloveNum = int(_sloveNumTxt.text);
         sloveNumChangeHandler();
      }
      
      private function __addHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         _sloveNum = _sloveNum + 1;
         sloveNumChangeHandler();
      }
      
      private function __deleteHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         _sloveNum = _sloveNum - 1;
         sloveNumChangeHandler();
      }
      
      private function sloveNumChangeHandler() : void
      {
         var _loc1_:int = 0;
         if(_sloveNum > _limit)
         {
            _sloveNum = _limit;
         }
         if(_sloveNum < 0)
         {
            _sloveNum = 0;
         }
         if(rInfo)
         {
            _loc1_ = _sloveNum * rInfo.Count1;
         }
         _getTxt.text = "" + _loc1_;
         _sloveNumTxt.text = "" + _sloveNum;
         _sloveNum <= 1 ? (_deleteBtn.enable = false) : (Boolean(_deleteBtn.enable = true));
         _sloveNum >= _limit ? (_addBtn.enable = false) : (Boolean(_addBtn.enable = true));
         _btn.enable = _sloveNum > 0 ? true : false;
      }
      
      public function show() : void
      {
         titleText = LanguageMgr.GetTranslation("demonroad.shop.solveTitle");
         LayerManager.Instance.addToLayer(this,3,true,true,1,0,true);
         KeyBoardRegister.instance.keyEnable = false;
         StageReferance.stage.focus = _sloveNumTxt;
      }
      
      override public function get groups() : Array
      {
         return [ComponentGroupType.NONE];
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_sloveNumTxt);
         _sloveNumTxt = null;
         ObjectUtils.disposeObject(_addBtn);
         _addBtn = null;
         ObjectUtils.disposeObject(_deleteBtn);
         _deleteBtn = null;
         ObjectUtils.disposeObject(_getTxt);
         _getTxt = null;
         ObjectUtils.disposeObject(_icon);
         _icon = null;
         ObjectUtils.disposeObject(_img);
         _img = null;
         ObjectUtils.disposeObject(_btn);
         _btn = null;
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         super.dispose();
         KeyBoardRegister.instance.keyEnable = true;
         _gInfo = null;
         rInfo = null;
      }
   }
}

