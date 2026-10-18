package ui.toptoolbar.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.container.SimpleTileList;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import flash.display.Bitmap;
   import flash.events.MouseEvent;
   import flash.utils.Dictionary;
   import manager.LanguageMgr;
   import ui.toptoolbar.TopBtnType;
   import yishi.SwitchPageHelp;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.filter.UIFilter;
   import yishi.manager.ArmyManager;
   import yishi.manager.FrameControllerManager;
   import yishi.scene.SceneManager;
   import yishi.view.component.MovieButton;
   import yishi.view.tips.MessageTipManager;
   
   public class TimeActiveBoxView extends Component
   {
      
      private var back:ScaleBitmapImage;
      
      private var btnList:SimpleTileList;
      
      private var btnDic:Dictionary;
      
      private var textDic:Dictionary;
      
      public function TimeActiveBoxView()
      {
         super();
         initView();
         initListView();
      }
      
      private function initView() : void
      {
         back = ComponentFactory.Instance.creatComponentByStylename("TimeActiveBoxView.back");
         btnList = ComponentFactory.Instance.creatCustomObject("TimeActiveBoxView.SimpleTileList",[4]);
         addChild(back);
         addChild(btnList);
      }
      
      private function initListView() : void
      {
         var _loc3_:int = 0;
         var _loc4_:MovieButton = null;
         var _loc1_:Bitmap = null;
         var _loc2_:FilterFrameText = null;
         btnDic = new Dictionary();
         textDic = new Dictionary();
         _loc3_ = 0;
         while(_loc3_ < TopBtnType.TIME_ACTIVE_BTNS.length)
         {
            _loc4_ = ComponentFactory.Instance.creatComponentByStylename("toptoolbar.topBtn");
            _loc1_ = ComponentFactory.Instance.creatBitmap("asset.toptoolbar.topIcon_" + TopBtnType.TIME_ACTIVE_BTNS[_loc3_]);
            _loc2_ = ComponentFactory.Instance.creatComponentByStylename("toptoolbar.topBtn.stateText");
            if(_loc1_ && _loc4_)
            {
               _loc4_.movie.movie["icon"].addChild(_loc1_);
            }
            if(_loc2_ && _loc4_)
            {
               _loc4_.addChild(_loc2_);
            }
            _loc2_.setFrame(1);
            if(_loc4_)
            {
               _loc4_.movie.movie["effect"]["effect_01"].gotoAndStop(1);
            }
            _loc4_.addEventListener("click",__btnClickHandler);
            btnDic[TopBtnType.TIME_ACTIVE_BTNS[_loc3_]] = _loc4_;
            textDic[TopBtnType.TIME_ACTIVE_BTNS[_loc3_]] = _loc2_;
            btnList.addChild(_loc4_);
            _loc3_++;
         }
         btnList.commitChanges();
      }
      
      private function __btnClickHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("015");
         param1.currentTarget.movie.movie["effect"]["effect_01"].gotoAndStop(1);
         switch(param1.currentTarget)
         {
            case btnDic["pvp"]:
               if(!checkIsOpen(0))
               {
                  return;
               }
               FrameControllerManager.instance.openControllerByInfo("pvproomlist");
               break;
            case btnDic["rvr1"]:
               if(!checkIsOpen(1))
               {
                  return;
               }
               FrameControllerManager.instance.openControllerByInfo("worldboss",3);
               break;
            case btnDic["worldboss"]:
               if(!checkIsOpen(2))
               {
                  return;
               }
               FrameControllerManager.instance.openControllerByInfo("worldboss",1);
               break;
            case btnDic["vehicel"]:
               if(!checkIsOpen(3))
               {
                  return;
               }
               if(SwitchPageHelp.checkScene())
               {
                  FrameControllerManager.instance.openControllerByInfo("vehicleroomlist");
               }
               break;
            case btnDic["crossmuticampaign"]:
               if(!checkIsOpen(4))
               {
                  return;
               }
               FrameControllerManager.instance.openControllerByInfo("pveroomlist");
               break;
            case btnDic["childArena"]:
               if(!checkIsRightScene())
               {
                  return;
               }
               if(!checkIsOpen(5))
               {
                  return;
               }
               FrameControllerManager.instance.openControllerByInfo("childarena");
               break;
            case btnDic["poker"]:
               if(!checkIsRightScene())
               {
                  return;
               }
               if(!checkIsOpen(6))
               {
                  return;
               }
               FrameControllerManager.instance.openControllerByInfo("poker");
               break;
            case btnDic["giftwill"]:
               if(thane.grades < 32)
               {
                  MessageTipManager.instance().show(LanguageMgr.GetTranslation("toptoolbar.topBtn.tipData.alert",32));
                  return;
               }
               FrameControllerManager.instance.openControllerByInfo("magicpub",0,3);
         }
      }
      
      private function checkIsRightScene() : Boolean
      {
         if(SceneManager.instance.currentType == "CASTLE_SCENE" || SceneManager.instance.currentType == "SPACE_SCENE")
         {
            return true;
         }
         MessageTipManager.instance().show(LanguageMgr.GetTranslation("TimeActiveBoxView.notInRightScene.alert"));
         return false;
      }
      
      private function checkIsOpen(param1:int) : Boolean
      {
         var _loc2_:int = TimeActiveBoxOpenTime.instance.getOpenStateByIndex(param1);
         var _loc3_:int = int(TopBtnType.TIME_ACTIVE_GRADES[param1]);
         if(thane.grades < _loc3_)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("toptoolbar.topBtn.tipData.alert",_loc3_));
            return false;
         }
         if(_loc2_ == TopBtnType.TIME_ACTIVE_STATE[3])
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("consortia.data.ConsortiaDemonInfo.overTip"));
            return false;
         }
         if(_loc2_ == TopBtnType.TIME_ACTIVE_STATE[2])
         {
            return true;
         }
         MessageTipManager.instance().show(LanguageMgr.GetTranslation("consortia.data.ConsortiaDemonInfo.unopenTip"));
         return false;
      }
      
      public function refreshView() : void
      {
         var _loc2_:int = 0;
         var _loc5_:int = 0;
         var _loc1_:Array = null;
         var _loc3_:String = null;
         var _loc4_:int = 0;
         for(var _loc6_:String in btnDic)
         {
            _loc2_ = TopBtnType.TIME_ACTIVE_BTNS.indexOf(_loc6_);
            _loc5_ = TimeActiveBoxOpenTime.instance.getOpenStateByIndex(_loc2_);
            if(textDic[_loc6_] as FilterFrameText)
            {
               (textDic[_loc6_] as FilterFrameText).text = LanguageMgr.GetTranslation("toptoolbar.topBtn.stateText" + _loc5_);
               (textDic[_loc6_] as FilterFrameText).setFrame(_loc5_ + 1);
            }
            if(_loc5_ == TopBtnType.TIME_ACTIVE_STATE[2])
            {
               (btnDic[_loc6_] as MovieButton).movie.movie["effect"]["effect_01"].play();
            }
            _loc1_ = TimeActiveBoxOpenTime.instance.getOpenTimeByIndex(_loc2_);
            if(_loc6_ == "rvr1")
            {
               _loc1_ = ["13:00,23:30"];
            }
            _loc3_ = LanguageMgr.GetTranslation("toptoolbar.topBtn.tipData");
            _loc4_ = 0;
            while(_loc4_ < _loc1_.length)
            {
               _loc3_ += "\n" + _loc1_[_loc4_].replace(",","-");
               (btnDic[_loc6_] as MovieButton).tipData = _loc3_;
               _loc4_++;
            }
            if(thane.grades < TopBtnType.TIME_ACTIVE_GRADES[_loc2_])
            {
               (btnDic[_loc6_] as MovieButton).tipData = LanguageMgr.GetTranslation("toptoolbar.topBtn.tipData.alert",TopBtnType.TIME_ACTIVE_GRADES[_loc2_]);
               (btnDic[_loc6_] as MovieButton).filters = [UIFilter.getGrayFilter()];
            }
            else
            {
               (btnDic[_loc6_] as MovieButton).filters = [];
            }
         }
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,7);
         refreshView();
      }
      
      private function get thane() : ThaneInfo
      {
         return ArmyManager.instance.thane;
      }
      
      override public function dispose() : void
      {
         if(back)
         {
            ObjectUtils.disposeObject(back);
         }
         back = null;
         for each(var _loc1_:MovieButton in btnDic)
         {
            _loc1_.removeEventListener("click",__btnClickHandler);
            ObjectUtils.disposeObject(_loc1_);
            _loc1_ = null;
         }
         btnDic = null;
         if(btnList)
         {
            ObjectUtils.disposeObject(btnList);
         }
         btnList = null;
         super.dispose();
      }
   }
}

