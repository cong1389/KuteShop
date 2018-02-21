using App.Core.Common;
using App.Core.Utils;
using App.Domain.Interfaces.Repository;
using App.Infra.Data.DbFactory;
using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Linq.Expressions;

namespace App.Infra.Data.Common
{
    public abstract class RepositoryBase<T> : IRepositoryBase<T>
    where T : BaseEntity
    {
        private readonly IDbSet<T> _dbSet;

        private Context.AppContext _dataContext;

        protected Context.AppContext DbContext
        {
            get
            {
                Context.AppContext appContext = _dataContext;
                if (appContext == null)
                {
                    Context.AppContext appContext1 = DbFactory.Init();
                    Context.AppContext appContext2 = appContext1;
                    _dataContext = appContext1;
                    appContext = appContext2;
                }
                return appContext;
            }
        }

        protected IDbFactory DbFactory
        {
            get;
        }

        protected RepositoryBase(IDbFactory dbFactory)
        {
            DbFactory = dbFactory;
            _dbSet = DbContext.Set<T>();
        }

        public virtual T Add(T entity)
        {
            return _dbSet.Add(entity);
        }

        public void BactchAdd(IEnumerable<T> entity)
        {
            foreach (T t in _dbSet.AsEnumerable<T>())
            {
                _dbSet.Add(t);
            }
        }

        public virtual void Delete(Expression<Func<T, bool>> where)
        {
            foreach (T t in _dbSet.Where<T>(where).AsEnumerable<T>())
            {
                _dataContext.Entry<T>(t).State = EntityState.Deleted;
                _dbSet.Remove(t);
            }
        }

        public virtual void Delete(T entity)
        {
            _dataContext.Entry<T>(entity).State = EntityState.Deleted;
            _dbSet.Remove(entity);
        }

        public virtual IEnumerable<T> Find(Expression<Func<T, bool>> whereClause, Paging page)
        {
            page.TotalRecord = _dbSet.AsNoTracking<T>().Where<T>(whereClause).Count<T>();
            IEnumerable<T> list = GetDefaultOrder(_dbSet.AsNoTracking<T>()).Where<T>(whereClause).Skip<T>((page.PageNumber - 1) * page.PageSize).Take<T>(page.PageSize).ToList<T>();
            return list;
        }

        public virtual IEnumerable<T> Find<TKey>(Expression<Func<T, bool>> whereClause, Expression<Func<T, TKey>> orderByClause, Paging page)
        {
            page.TotalRecord = _dbSet.AsNoTracking<T>().Where<T>(whereClause).Count<T>();
            IEnumerable<T> list = _dbSet.AsNoTracking<T>().Where<T>(whereClause).OrderBy<T, TKey>(orderByClause).Skip<T>((page.PageNumber - 1) * page.PageSize).Take<T>(page.PageSize).ToList<T>();
            return list;
        }

        public virtual IEnumerable<T> FindAndSort(Expression<Func<T, bool>> whereClause, SortBuilder sortBuilder, Paging page)
        {
            IEnumerable<T> list;
            page.TotalRecord = _dbSet.AsNoTracking<T>().Where<T>(whereClause).Count<T>();
            if (!string.IsNullOrEmpty(sortBuilder.ColumnName))
            {
                list = (sortBuilder.ColumnOrder != SortBuilder.SortOrder.Descending ? _dbSet.OrderBy<T>(sortBuilder.ColumnName).AsNoTracking<T>().Where<T>(whereClause).Skip<T>((page.PageNumber - 1) * page.PageSize).Take<T>(page.PageSize).ToList<T>() : _dbSet.OrderByDescending<T>(sortBuilder.ColumnName).AsNoTracking<T>().Where<T>(whereClause).Skip<T>((page.PageNumber - 1) * page.PageSize).Take<T>(page.PageSize).ToList<T>());
            }
            else
            {
                list = GetDefaultOrder(_dbSet.AsNoTracking<T>()).Where<T>(whereClause).Skip<T>((page.PageNumber - 1) * page.PageSize).Take<T>(page.PageSize).ToList<T>();
            }
            return list;
        }

        public virtual IEnumerable<T> FindBy(Expression<Func<T, bool>> predicate, bool @readonly = false)
        {
            return (@readonly ? _dbSet.AsNoTracking<T>().Where<T>(predicate).ToList<T>() : _dbSet.Where<T>(predicate).ToList<T>());
        }

        public virtual T Get(Expression<Func<T, bool>> where, bool @readonly = false)
        {
            return (@readonly ? _dbSet.AsNoTracking<T>().Where<T>(where).FirstOrDefault<T>() : _dbSet.Where<T>(where).FirstOrDefault<T>());
        }

        public virtual IEnumerable<T> GetAll()
        {
            return _dbSet.AsNoTracking<T>().ToList<T>();
        }

        public virtual IEnumerable<T> GetAllPagedList(Paging page)
        {
            page.TotalRecord = _dbSet.Count<T>();
            IEnumerable<T> list = GetDefaultOrder(_dbSet.AsNoTracking<T>()).Skip<T>((page.PageNumber - 1) * page.PageSize).Take<T>(page.PageSize).ToList<T>();
            return list;
        }

        protected abstract IOrderedQueryable<T> GetDefaultOrder(IQueryable<T> query);

        public IEnumerable<T> GetTop(int take)
        {
            IEnumerable<T> ts = _dbSet.AsNoTracking<T>().Take<T>(take);
            return ts;
        }

        public IEnumerable<T> GetTopBy(int take, Expression<Func<T, bool>> where)
        {
            IEnumerable<T> ts = _dbSet.AsNoTracking<T>().Where<T>(where).Take<T>(take);
            return ts;
        }

        public IEnumerable<T> GetTopBy<TKey>(int take, Expression<Func<T, bool>> where, Expression<Func<T, TKey>> orderByClause)
        {
            IEnumerable<T> ts = _dbSet.AsNoTracking<T>().OrderByDescending<T, TKey>(orderByClause).Where<T>(where).Take<T>(take);
            return ts;
        }

        public virtual void Update(T entity)
        {
            _dbSet.Attach(entity);
            _dataContext.Entry<T>(entity).State = EntityState.Modified;
        }

        public virtual IQueryable<T> Table
        {
            get
            {
                //if (_dataContext.ForceNoTracking)
                //{
                //    return this._dbSet.AsNoTracking();
                //}
                return _dbSet;
            }
        }
    }
}