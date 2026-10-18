package theseusdoublepvp
{
   import bag.events.BagEvent;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import managers.TheseusPvpManager;
   import yishi.datas.ComponentGroupType;
   import yishi.datas.goods.GoodsInfo;
   import yishi.keyboard.KeyBoardRegister;
   import yishi.manager.GoodsManager;
   import yishi.view.community.BaseItemView;
   
   public class TheseusDoublePvpBuyTimeFrame extends Frame
   {
      
      private var _backGroud:Bitmap;
      
      private var _sp:Sprite;
      
      private var _img:Image;
      
      private var _addNumTxt:FilterFrameText;
      
      private var _addBtn:BaseButton;
      
      private var _deleteBtn:BaseButton;
      
      private var _icon:BaseItemView;
      
      private var _btn:IconButton;
      
      private var _addNum:int = 0;
      
      private var _limit:int;
      
      private var _goodNameTxt:FilterFrameText;
      
      private var _tipTxt1:FilterFrameText;
      
      private var _tipTxt2:FilterFrameText;
      
      private const GOODS_ID:int = 7640004;
      
      private var _gd:GoodsInfo;
      
      public function TheseusDoublePvpBuyTimeFrame()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _backGroud = ComponentFactory.Instance.creatBitmap("asset.theseuspvp.addTimeBg");
         _img = ComponentFactory.Instance.creatComponentByStylename("theseuspvp.addInputBg");
         _addNumTxt = ComponentFactory.Instance.creatComponentByStylename("quickbuy.BuyNumTextStyle");
         _addBtn = ComponentFactory.Instance.creatComponentByStylename("quickbuy.AddButton");
         _deleteBtn = ComponentFactory.Instance.creatComponentByStylename("quickbuy.DeleteButton");
         _sp = ComponentFactory.Instance.creatCustomObject("theseuspvp.buyTimeContainer");
         _btn = ComponentFactory.Instance.creatComponentByStylename("theseuspvp.butTimeBtn");
         _goodNameTxt = ComponentFactory.Instance.creatComponentByStylename("ui.theseuspvp.buyIconNameTxt");
         _tipTxt1 = ComponentFactory.Instance.creatComponentByStylename("ui.theseuspvp.buyTitleTxt");
         _tipTxt2 = ComponentFactory.Instance.creatComponentByStylename("ui.theseuspvp.buyTipTxt");
         _icon = ComponentFactory.Instance.creatCustomObject("theseuspvp.buyTimeBaseItem");
         _sp.addChild(_img);
         _sp.addChild(_addNumTxt);
         _sp.addChild(_addBtn);
         _sp.addChild(_deleteBtn);
         addToContent(_backGroud);
         addToContent(_sp);
         addToContent(_icon);
         addToContent(_btn);
         addToContent(_goodNameTxt);
         addToContent(_tipTxt1);
         addToContent(_tipTxt2);
         _gd = new GoodsInfo();
         _gd.templateId = 7640004;
         _icon.data = _gd;
         _addNumTxt.text = "0";
         refreshGoodsHandler();
         sloveNumChangeHandler();
         _tipTxt1.text = LanguageMgr.GetTranslation("theseuspvp.addT1");
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
         if(_addNumTxt)
         {
            _addNumTxt.addEventListener("change",__sloveNumChange);
         }
         if(_btn)
         {
            _btn.addEventListener("click",_sloveClickHandler);
         }
         GoodsManager.instance.addEventListener("DELETE_BAG",refreshGoodsHandler);
         GoodsManager.instance.addEventListener("UPDATE_BAG",refreshGoodsHandler);
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
         if(_addNumTxt)
         {
            _addNumTxt.removeEventListener("change",__sloveNumChange);
         }
         if(_btn)
         {
            _btn.removeEventListener("click",_sloveClickHandler);
         }
         GoodsManager.instance.removeEventListener("DELETE_BAG",refreshGoodsHandler);
         GoodsManager.instance.removeEventListener("UPDATE_BAG",refreshGoodsHandler);
      }
      
      private function refreshGoodsHandler(param1:BagEvent = null) : void
      {
         _limit = GoodsManager.instance.getBagCountByTempId(1,7640004);
         _addNumTxt.text = "0";
         _goodNameTxt.text = LanguageMgr.GetTranslation("theseuspvp.hasLimit",_gd.templateInfo.TemplateName,_limit);
      }
      
      private function _sloveClickHandler(param1:MouseEvent) : void
      {
         TheseusPvpManager.Instance.doSomething1(14,0,_addNum);
         super.dispose();
      }
      
      private function __sloveNumChange(param1:Event) : void
      {
         _addNum = int(_addNumTxt.text);
         sloveNumChangeHandler();
      }
      
      private function __addHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         _addNum = _addNum + 1;
         sloveNumChangeHandler();
      }
      
      private function __deleteHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         _addNum = _addNum - 1;
         sloveNumChangeHandler();
      }
      
      private function sloveNumChangeHandler() : void
      {
         if(_addNum > _limit)
         {
            _addNum = _limit;
         }
         if(_addNum < 0)
         {
            _addNum = 0;
         }
         _addNumTxt.text = "" + _addNum;
         _addNum < 1 ? (_deleteBtn.enable = false) : (Boolean(_deleteBtn.enable = true));
         _addNum >= _limit ? (_addBtn.enable = false) : (Boolean(_addBtn.enable = true));
         _btn.enable = _addNum > 0 ? true : false;
      }
      
      private function __frameResponse(param1:FrameEvent) : void
      {
         switch(int(param1.responseCode))
         {
            case 0:
            case 1:
               dispose();
         }
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_addNumTxt);
         _addNumTxt = null;
         ObjectUtils.disposeObject(_addBtn);
         _addBtn = null;
         ObjectUtils.disposeObject(_deleteBtn);
         _deleteBtn = null;
         ObjectUtils.disposeObject(_icon);
         _icon = null;
         ObjectUtils.disposeObject(_img);
         _img = null;
         ObjectUtils.disposeObject(_btn);
         _btn = null;
         ObjectUtils.disposeObject(_backGroud);
         _backGroud = null;
         ObjectUtils.disposeObject(_goodNameTxt);
         _goodNameTxt = null;
         ObjectUtils.disposeObject(_tipTxt1);
         _tipTxt1 = null;
         ObjectUtils.disposeObject(_tipTxt2);
         _tipTxt2 = null;
         super.dispose();
         KeyBoardRegister.instance.keyEnable = true;
         _gd = null;
      }
      
      public function show() : void
      {
         titleText = LanguageMgr.GetTranslation("theseuspvp.addTimeFrameTitle");
         LayerManager.Instance.addToLayer(this,3,true,true,1);
         KeyBoardRegister.instance.keyEnable = false;
         StageReferance.stage.focus = _addNumTxt;
      }
      
      override public function get groups() : Array
      {
         return [ComponentGroupType.NONE];
      }
   }
}

