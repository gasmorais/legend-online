package allmanexchange
{
   import allmanexchange.item.AllManExchangeBigBox;
   import allmanexchange.item.AllManExchangeSmallBox;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.loader.LoaderManagerII;
   import com.pickgliss.loader.data.LoaderInfo;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.ComponentSetting;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import events.AllManExchangeEvent;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.net.URLVariables;
   import manager.LanguageMgr;
   import mvc.ModuleFrameInfo;
   import mvc.module.allmanexchange.AllManExchangeModel;
   import yishi.datas.ComponentGroupType;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.playerinfo.PlayerModel;
   import yishi.manager.AllManExchangeManager;
   import yishi.manager.GoodsManager;
   import yishi.manager.PlayerManager;
   import yishi.utils.DateFormatter;
   import yishi.utils.HashMap;
   import yishi.utils.TimerUtils;
   import yishi.view.community.BaseItemView;
   import yishi.view.frame.SimpleHelpFrame;
   
   public class AllManExchangeFrame extends Frame
   {
      
      private var _bg:Bitmap;
      
      private var _txtTime:FilterFrameText;
      
      private var _txtTodayCount:FilterFrameText;
      
      private var _txtAllScore:FilterFrameText;
      
      private var _bit0:Bitmap;
      
      private var _pic1:MutipleImage;
      
      private var _border:ScaleBitmapImage;
      
      private var _btnHelp:BaseButton;
      
      private var posBigBox:Array = [[39,78],[269,78],[499,78]];
      
      private var posSmallBox:Array = [[165,318],[273,318],[381,318],[489,318],[597,318]];
      
      private var mapBigBox:HashMap;
      
      private var mapSmallBox:HashMap;
      
      private var spMask:Sprite;
      
      private var item:BaseItemView;
      
      public function AllManExchangeFrame()
      {
         super();
         initView();
         addEvent();
      }
      
      override public function get groups() : Array
      {
         return [ComponentGroupType.NONE];
      }
      
      private function initView() : void
      {
         _txtTime = ComponentFactory.Instance.creatComponentByStylename("ui.allmanexchange.txtTime");
         _txtTodayCount = ComponentFactory.Instance.creatComponentByStylename("ui.allmanexchange.txtTodayCount");
         _txtAllScore = ComponentFactory.Instance.creatComponentByStylename("ui.allmanexchange.txtAllScore");
         _bit0 = ComponentFactory.Instance.creatBitmap("asset.allmanexchange.img4");
         _pic1 = ComponentFactory.Instance.creatComponentByStylename("ui.allmanexchange.pic1");
         _border = ComponentFactory.Instance.creatComponentByStylename("allmanexchange.AllManExchangeFrame.border");
         item = ComponentFactory.Instance.creatCustomObject("allmanexchange.AllManExchangeFrame.item");
         _btnHelp = ComponentFactory.Instance.creatComponentByStylename("allmanexchange.AllManExchangeFrame.helpBtn");
         addToContent(_border);
         addToContent(_pic1);
         addToContent(_bit0);
         addToContent(_txtTime);
         addToContent(_txtTodayCount);
         addToContent(_txtAllScore);
         addToContent(item);
         addToContent(_btnHelp);
         spMask = new Sprite();
         spMask.x = _bit0.x;
         spMask.y = _bit0.y;
         spMask.graphics.beginFill(16777215,1);
         spMask.graphics.drawRect(0,0,_bit0.width,_bit0.height);
         spMask.graphics.endFill();
         addToContent(spMask);
         _bit0.mask = spMask;
         initBox();
         AllManExchangeManager.instance.sendOpenView();
         updateInfo();
         loadBg();
      }
      
      private function loadBg() : void
      {
         LoaderManagerII.instance.clearLoaderInfoByCompleteFunction(onloadBgComplete);
         var _loc1_:URLVariables = new URLVariables();
         _loc1_["rnd"] = ComponentSetting.LOGIN_RND;
         var _loc2_:String = ComponentSetting.RESOURCE_PATH + "allmanexchange.jpg";
         LoaderManagerII.instance.load(_loc2_,2,8,onloadBgComplete,null,null,null,_loc1_);
      }
      
      private function onloadBgComplete(param1:LoaderInfo, param2:Object) : void
      {
         if(param2)
         {
            _bg = param2 as Bitmap;
            addToContentAt(_bg,1);
         }
      }
      
      private function initBox() : void
      {
         var _loc1_:AllManExchangeBigBox = null;
         var _loc2_:int = 0;
         var _loc3_:AllManExchangeSmallBox = null;
         mapBigBox = new HashMap();
         _loc2_ = 0;
         while(_loc2_ < 3)
         {
            _loc1_ = new AllManExchangeBigBox(_loc2_);
            addToContent(_loc1_);
            _loc1_.x = posBigBox[_loc2_][0];
            _loc1_.y = posBigBox[_loc2_][1];
            mapBigBox.put(_loc2_,_loc1_);
            _loc2_++;
         }
         mapSmallBox = new HashMap();
         _loc2_ = 0;
         while(_loc2_ < 5)
         {
            _loc3_ = new AllManExchangeSmallBox(_loc2_);
            addToContent(_loc3_);
            _loc3_.x = posSmallBox[_loc2_][0];
            _loc3_.y = posSmallBox[_loc2_][1];
            mapSmallBox.put(_loc2_,_loc3_);
            _loc2_++;
         }
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__frameResponse);
         AllManExchangeManager.instance.addEventListener("UPDATE_INFO",updateInfo);
         TimerUtils.addSecendTimer("allmanexchange",1,2147483647,tick);
         _btnHelp.addEventListener("click",onClickHelp);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         AllManExchangeManager.instance.removeEventListener("UPDATE_INFO",updateInfo);
         TimerUtils.removeSecendTimer("allmanexchange");
         _btnHelp.removeEventListener("click",onClickHelp);
      }
      
      private function onClickHelp(param1:MouseEvent) : void
      {
         var _loc2_:SimpleHelpFrame = ComponentFactory.Instance.creatComponentByStylename("allmanexchange.AllManExchangeFrame.helpFrame");
         _loc2_.show();
      }
      
      private function tick() : void
      {
         var _loc1_:Number = Number(DateFormatter.parse(model.end,"YYYY-MM-DD hh:mm:ss").time);
         _loc1_ = (_loc1_ - playerModel.sysCurtime.time) / 1000;
         _txtTime.text = DateFormatter.getDefaultFullDateString(_loc1_);
      }
      
      private function get playerModel() : PlayerModel
      {
         return PlayerManager.instance.currentPlayerModel;
      }
      
      private function updateInfo(param1:AllManExchangeEvent = null) : void
      {
         var _loc3_:AllManExchangeBigBox = null;
         var _loc4_:int = 0;
         var _loc5_:AllManExchangeSmallBox = null;
         if(model.allChangeCount == 0)
         {
            _txtTodayCount.visible = false;
         }
         _txtTodayCount.text = LanguageMgr.GetTranslation("allmainexchange.str2",model.allChangeCount - model.changeItemCount,model.allChangeCount);
         _txtAllScore.text = model.allPoint + "";
         _loc4_ = 0;
         while(_loc4_ < 3)
         {
            _loc3_ = mapBigBox.getValue(_loc4_) as AllManExchangeBigBox;
            _loc3_.update();
            _loc4_++;
         }
         spMask.width = 0;
         _loc4_ = 0;
         while(_loc4_ < 5)
         {
            _loc5_ = mapSmallBox.getValue(_loc4_) as AllManExchangeSmallBox;
            _loc5_.update();
            if(model.allPoint == model.allPointAward[_loc4_])
            {
               spMask.width = _loc5_.x - 65;
            }
            else if(model.allPoint > model.allPointAward[_loc4_])
            {
               spMask.width = _loc5_.x - 20;
            }
            _loc4_++;
         }
         var _loc2_:GoodsInfo = new GoodsInfo();
         _loc2_.templateId = model.changeItem;
         _loc2_.count = GoodsManager.instance.getBagCountInPlayerAndStoneByTempId(model.changeItem);
         item.data = _loc2_;
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
      
      public function show(param1:ModuleFrameInfo = null) : void
      {
         LayerManager.Instance.addToLayer(this,3,true,true,1);
         titleText = LanguageMgr.GetTranslation("allmainexchange.str1");
      }
      
      private function get model() : AllManExchangeModel
      {
         return AllManExchangeManager.instance.model;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_txtTime);
         _txtTime = null;
         ObjectUtils.disposeObject(_txtTodayCount);
         _txtTodayCount = null;
         ObjectUtils.disposeObject(_txtAllScore);
         _txtAllScore = null;
         ObjectUtils.disposeObject(_bit0);
         _bit0 = null;
         ObjectUtils.disposeObject(_pic1);
         _pic1 = null;
         ObjectUtils.disposeObject(_border);
         _border = null;
         ObjectUtils.disposeObject(item);
         item = null;
         if(parent)
         {
            parent.removeChild(this);
         }
         super.dispose();
      }
   }
}

