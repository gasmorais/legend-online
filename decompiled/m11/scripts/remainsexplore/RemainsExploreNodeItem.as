package remainsexplore
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import mvc.module.remainsexplore.RemainsExploreModel;
   import mvc.module.remainsexplore.RemainsExploreNodeInfo;
   import yishi.filter.UIFilter;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.RemainsExploreManager;
   import yishi.utils.MsgMan;
   import yishi.view.tips.MessageTipManager;
   
   public class RemainsExploreNodeItem extends Component
   {
      
      private var _bg:ScaleFrameImage;
      
      private var _boss1:Bitmap;
      
      private var _boss2:Bitmap;
      
      private var _txtBg:Bitmap;
      
      private var _txt:FilterFrameText;
      
      private var _lock:Bitmap;
      
      private var _areaId:int;
      
      private var _index:int;
      
      public function RemainsExploreNodeItem(param1:int, param2:int)
      {
         super();
         _areaId = param1;
         _index = param2;
         initView();
         addEvent();
         this.buttonMode = true;
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatComponentByStylename("remainsExploreNodeItem.bg" + _areaId);
         _boss1 = ComponentFactory.Instance.creatBitmap("asset.RemainsExploreNodeItem.boss1");
         _boss2 = ComponentFactory.Instance.creatBitmap("asset.RemainsExploreNodeItem.boss2");
         _txtBg = ComponentFactory.Instance.creatBitmap("asset.RemainsExploreNodeItem.txtBg");
         _txt = ComponentFactory.Instance.creatComponentByStylename("remainsExploreNodeItem.txt");
         _lock = ComponentFactory.Instance.creatBitmap("asset.RemainsExploreNodeItem.lock");
         addChild(_bg);
         addChild(_txtBg);
         addChild(_txt);
         addChild(_boss1);
         addChild(_boss2);
         addChild(_lock);
         refreshView();
      }
      
      private function addEvent() : void
      {
         addEventListener("rollOver",__mouseOverHandler);
         addEventListener("rollOut",__mouseOutHandler);
         addEventListener("click",__nodeClickHandler);
         MsgMan.addObserver("EXPLORE_INFO_UPDATE",this,__updateInfoHandler);
         MsgMan.addObserver("DO_EXPLORE_UPDATE",this,__updateInfoHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("rollOver",__mouseOverHandler);
         removeEventListener("rollOut",__mouseOutHandler);
         removeEventListener("click",__nodeClickHandler);
         MsgMan.removeObserver("EXPLORE_INFO_UPDATE",this,__updateInfoHandler);
         MsgMan.removeObserver("DO_EXPLORE_UPDATE",this,__updateInfoHandler);
      }
      
      private function __updateInfoHandler(param1:String, param2:Object) : void
      {
         refreshView();
      }
      
      private function __mouseOverHandler(param1:MouseEvent) : void
      {
         this.filters = [UIFilter.getLightingFilter()];
      }
      
      private function __mouseOutHandler(param1:MouseEvent) : void
      {
         this.filters = [];
      }
      
      private function __nodeClickHandler(param1:MouseEvent) : void
      {
         var _loc2_:RemainsExploreNodeInfo = model.getInfoById(_areaId,_index);
         if(!_loc2_)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("remainsExploreNodeItem.locked.text"));
            return;
         }
         model.tempAreaId = _areaId;
         model.tempNodeId = _index;
         FrameControllerManager.instance.openControllerByInfo("remainsexplore",2);
      }
      
      public function refreshView() : void
      {
         _bg.setFrame(_index);
         var _loc1_:RemainsExploreNodeInfo = model.getInfoById(_areaId,_index);
         if(_loc1_)
         {
            _lock.visible = false;
            _txtBg.visible = true;
            _txt.visible = true;
            _boss1.visible = _loc1_.isShowBoss1;
            _boss2.visible = _loc1_.isShowBoss2;
            _txt.text = LanguageMgr.GetTranslation("remainsExploreNodeItem.txt.text",_loc1_.progress);
            if(_loc1_.checkpointId == model.boss1NodeId)
            {
               _boss1.visible = true;
            }
            if(_loc1_.checkpointId == model.boss2NodeId)
            {
               _boss2.visible = true;
            }
         }
         else
         {
            _lock.visible = true;
            _boss1.visible = false;
            _boss2.visible = false;
            _txtBg.visible = false;
            _txt.visible = false;
         }
      }
      
      private function get model() : RemainsExploreModel
      {
         return RemainsExploreManager.instance.model;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_boss1);
         _boss1 = null;
         ObjectUtils.disposeObject(_boss2);
         _boss2 = null;
         ObjectUtils.disposeObject(_txtBg);
         _txtBg = null;
         ObjectUtils.disposeObject(_txt);
         _txt = null;
         ObjectUtils.disposeObject(_lock);
         _lock = null;
         ObjectUtils.disposeAllChildren(this);
         super.dispose();
      }
   }
}

