package im.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.cell.INotSameHeightListCellData;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import manager.LanguageMgr;
   import mvc.module.friends.BaseIMInfo;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.manager.PlayerManager;
   import yishi.utils.DateFormatter;
   
   public class IMHistoryCell extends Sprite implements INotSameHeightListCellData, Disposeable
   {
      
      private var _dateBg:Bitmap;
      
      private var _dateTxt:FilterFrameText;
      
      private var _nameTxt:FilterFrameText;
      
      private var _timeTxt:FilterFrameText;
      
      private var _msgTxt:FilterFrameText;
      
      private var _data:Object;
      
      public function IMHistoryCell()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         _dateBg = ComponentFactory.Instance.creatBitmap("asset.core.describeBackground_style017");
         _dateTxt = ComponentFactory.Instance.creatComponentByStylename("core.IMHistoryCellDateTxt");
         _nameTxt = ComponentFactory.Instance.creatComponentByStylename("core.IMHistoryCellNameTxt");
         _timeTxt = ComponentFactory.Instance.creatComponentByStylename("core.IMHistoryCellTimeTxt");
         _msgTxt = ComponentFactory.Instance.creatComponentByStylename("core.IMHistoryCellMsgTxt");
      }
      
      public function set data(param1:*) : void
      {
         if(_data)
         {
            _data = null;
            if(_dateBg.parent)
            {
               _dateBg.parent.removeChild(_dateBg);
            }
            if(_dateTxt.parent)
            {
               _dateTxt.parent.removeChild(_dateTxt);
            }
            if(_nameTxt.parent)
            {
               _nameTxt.parent.removeChild(_nameTxt);
            }
            if(_timeTxt.parent)
            {
               _timeTxt.parent.removeChild(_timeTxt);
            }
            if(_msgTxt.parent)
            {
               _msgTxt.parent.removeChild(_msgTxt);
            }
         }
         _data = param1;
         if(!_data)
         {
            return;
         }
         if(_data is Date)
         {
            _dateTxt.text = LanguageMgr.GetTranslation("friends.im.view.IMHistoryCell.date") + DateFormatter.format(_data as Date,"YYYY-MM-DD");
            addChild(_dateBg);
            addChild(_dateTxt);
         }
         else if(_data is BaseIMInfo)
         {
            _nameTxt.text = _data.nickName;
            _timeTxt.text = DateFormatter.format(_data.date,"hh:mm:ss");
            _timeTxt.x = _nameTxt.x + _nameTxt.width + 20;
            _msgTxt.text = _data.msg;
            if(playerInfo.userId == _data.userId)
            {
               _nameTxt.setFrame(1);
               _timeTxt.setFrame(1);
            }
            else
            {
               _nameTxt.setFrame(2);
               _timeTxt.setFrame(2);
            }
            addChild(_nameTxt);
            addChild(_timeTxt);
            addChild(_msgTxt);
         }
      }
      
      private function get playerInfo() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
      }
      
      public function getCellHeight() : Number
      {
         if(_data)
         {
            if(_data is Date)
            {
               return _dateBg.height;
            }
            if(_data is BaseIMInfo)
            {
               return _msgTxt.y + _msgTxt.height;
            }
         }
         return 0;
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeAllChildren(this);
         _dateBg = null;
         if(_dateTxt)
         {
            _dateTxt.dispose();
         }
         _dateTxt = null;
         if(_nameTxt)
         {
            _nameTxt.dispose();
         }
         _nameTxt = null;
         if(_timeTxt)
         {
            _timeTxt.dispose();
         }
         _timeTxt = null;
         if(_msgTxt)
         {
            _msgTxt.dispose();
         }
         _msgTxt = null;
         _data = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

